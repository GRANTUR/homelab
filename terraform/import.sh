#!/bin/bash
# Import existing OCI resources into Terraform state.
#
# Usage:
#   1. Fill in the OCIDs below from the OCI Console
#      (Networking > Virtual Cloud Networks > click your VCN)
#   2. Run: terraform init
#   3. Run: bash import.sh
#   4. Run: terraform plan  (should show 0 changes if config matches)
#
# The instance OCID is already known from metadata.
# Network OCIDs must be looked up in OCI Console or via OCI CLI:
#   oci network vcn list --compartment-id <COMPARTMENT_OCID>
#   oci network subnet list --compartment-id <COMPARTMENT_OCID>
#   oci network internet-gateway list --compartment-id <COMPARTMENT_OCID> --vcn-id <VCN_OCID>
#   oci network route-table list --compartment-id <COMPARTMENT_OCID> --vcn-id <VCN_OCID>
#   oci network security-list list --compartment-id <COMPARTMENT_OCID> --vcn-id <VCN_OCID>

set -euo pipefail

# --- Fill these in from OCI Console ---
VCN_OCID="ocid1.vcn.oc1.iad.amaaaaaaexozlxqa56jvtgonhvtg2s6tkbfrtzt3y6e6zv52fr6cgzztqofq"
SUBNET_OCID="ocid1.subnet.oc1.iad.aaaaaaaamw37vib4fixbqq6kpi2f275s2psimjcjrsvyieyvk24iabx2dioq"
IGW_OCID="ocid1.internetgateway.oc1.iad.aaaaaaaamh6shsjvksisjknxo6n6trisgyfopf32t2cubrxrwuzy3kbg4wha"
RT_OCID="ocid1.routetable.oc1.iad.aaaaaaaapjdark3ct3c7qk2obxivoxea4xa5ygsuvdehpyekhxlwensc6wia"
SL_OCID="ocid1.securitylist.oc1.iad.aaaaaaaa6yqr7o3mbfkmvvzkjqneyz3ekaxfchwsb2nwmqoed7opxmgaho4a"

# Instance OCIDs
HIGH_PALACE_OCID="ocid1.instance.oc1.iad.anuwcljrexozlxqcfdhythzoqt2ugjmm2ehcbhgl4eqyzkxxdm2wa5m5xnea"
STAR_GARDEN_OCID="ocid1.instance.oc1.iad.anuwcljrexozlxqcjzuf4vgmbeqg2w27ve4vi3jmn5p7sgvi7gx5bfhnwfvq"

echo "Importing OCI resources into Terraform state..."

terraform import oci_core_vcn.fortress_vcn "$VCN_OCID"
terraform import oci_core_internet_gateway.fortress_igw "$IGW_OCID"
terraform import oci_core_route_table.fortress_rt "$RT_OCID"
terraform import oci_core_security_list.fortress_sl "$SL_OCID"
terraform import oci_core_subnet.fortress_subnet "$SUBNET_OCID"
terraform import oci_core_instance.high_palace "$HIGH_PALACE_OCID"
terraform import oci_core_instance.star_garden "$STAR_GARDEN_OCID"

echo ""
echo "Import complete. Run 'terraform plan' to verify state matches config."
