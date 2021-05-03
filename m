Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4C37229D
	for <lists+linux-pwm@lfdr.de>; Mon,  3 May 2021 23:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhECVpZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 May 2021 17:45:25 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:41569
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhECVpZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 May 2021 17:45:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c21WAG5J4sojpbKuu6jyBb5CjNOI8psc8DW5WiD2eq6wVGwTq3q0cGNyoLf133U6jNz+IPqUJDcOxgKvJ7OI201xfOWb3qIkmwIn4dsFo1WVe1cEGiFrQynfV5RfB3Qy3pzxicE6ulNmdpVMvYYBsWIExWoZv0WdMnpYS1BhkUveLPtanrCpleoVpbfJ7Sdd1gtQ8ZYIVdYvMyAxyUxiWTshlE1sTP9n+kh1dXqyfVlYxfNIK3EQHZAsJ1t+ZfMYIrHW+Od+JcpFcQLyg62zkwwKba87JNpe4HhTRZM6AoW442lTFH6Du8xcozDn/V+d0uKtxoFzr1dJ6iEf78nytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzPQDyCMH518s+mK0FoyEHPTnQITD9ElOssQ5MZVz44=;
 b=DC2CVhP3ke9k6CrngtHV/3cEfp+OCSxjeaIDrNOPZGtbYS64zfUYzsDQXBeLlbqie6cM5kaW9fg7KmkyaJWIgksfgnI5J9tA/DkRLItp2e8zbdPT2VzHpcwlqKVRoZvCQLl5mNk+82nXLUVerg1WqhogzVul0N+Nd8PQfe4GV7RZkRpKrHoAVXq1HlEXlQjQGmzfhULxw6PGfVadctyZHbz5ho4kzxt3WvRYOL2t0QWagsWmqbSaW0T0AyXLsTgk6zfwyf1l5gs4xkhui7KnTAelncTNPClj1nju+RCioxny3ITUXdvZRNhoVtIytmbC8R+EI7HMIDH/nAUCJwvMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzPQDyCMH518s+mK0FoyEHPTnQITD9ElOssQ5MZVz44=;
 b=hi2WG3JZjJwBek/fgiQrRoxnZrzf11veXky50BY4IXQpIwcuRZwLgFTHf8SfstgTuzXkYENmRJBBz6JOMLdQiS5gAxRVX3nodR+9ZUByUiBS2fDO9ZuVfTTbIMyvrYRgRMeN4fUdcP9g1mgG6Vvp4caIjFNN+4c4hDci0AGHhZo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6201.eurprd03.prod.outlook.com (2603:10a6:10:13f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 21:44:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 21:44:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Mon,  3 May 2021 17:44:12 -0400
Message-Id: <20210503214413.3145015-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 21:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d44367f-a112-4e84-86ab-08d90e7ca11b
X-MS-TrafficTypeDiagnostic: DB8PR03MB6201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB6201E673CED36B54F0E67F61965B9@DB8PR03MB6201.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkQ4h/mJC40UvlXNp+ECJpwp8s8haKREY0BHmLVZIlVR5Kf054WJWuFVhvo+RUidZ5TmepPivyUxsMgxSFKRgbB1UBNmSCvX88/O3CzS8SlTybUSBw2gaWv19o5LtPGpeRjh6D8tyI/qZG0btBwOmJcqPAShPYKqNSAY9mUu+HPRMlKOBioqiiqejAkO8O8SWoHuvT+6npzQjdnr2cHjqXBivrvyqerl6aO1OimJUClr5YfPlV2ZoTzAYmSJSFujj0tsm3stdYkCLE+v/8ZilS6k4CuN+C1oWIO6OwBHVSWW7REbliDiaRYcNLPprF/KazHSsmwXw9Hs/OKbFdZc4mW6ef7UptwJkl807fFO0DlQTDf5JEf7aXSjF8QZHeEHbr9KL+RbhdllC8p5Z0dVMBPGeIiYTr7mhOL9N7w6tiYkgUDz5nGwt/4/nuOxsXCYL7gWydvtYtsvv4GHeZhwz/n76F5f6DDq/4w28eJB9NLbpBee8UetZBfXgJNT5JJWJGvDeDQaTbj7C933dSDi+8fAzxmc6fsIotUANMLymtG3s8EQskvaWg1FWMFeUXr62kgN4P820hSst6VSaU5WuFvpL0nyPkcOIhW4My0uemaQgqT4MmTBewoPWXi0ZjV1hAnRTJ2GyJQ9yoS04cnmLycjQ75x2IGalLXY4glpZrzMz+/Nk4ihossswxdA9eyGR58dAoC8hxvaomMoiYsSh7GiyfGvzk90ob6SEEbkiB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(8676002)(44832011)(1076003)(66556008)(66946007)(2906002)(54906003)(186003)(38350700002)(66476007)(38100700002)(83380400001)(6512007)(36756003)(26005)(16526019)(52116002)(5660300002)(4326008)(6506007)(6486002)(8936002)(508600001)(6666004)(956004)(86362001)(2616005)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x77N5C/t3titHSPmyinjgNXWCZirL8gZPUeirwTtjb0T2GVEgFpW3BFLgEn0?=
 =?us-ascii?Q?YCXyrK34UVhrP6bdrEPbQM9/sDLVkGjEhB4xZXEKl65v++U9JgP9tJ9TsloX?=
 =?us-ascii?Q?FSVYaJDAJ9QbmF+JlI7B2/lCTei70lS/Tj7MEBfClcyxb+zw2YAoUSo/FRpI?=
 =?us-ascii?Q?V9s917z/KhCYyzNpSH8T29qNW4r/lCU9BT41JWzItVDLuIXAkAnGUXjUS/dI?=
 =?us-ascii?Q?loIqvHzVxTV8zxGVl3Unb1RtYMqeH/J92HFTBO5Isf6jpeHTJ1i9DFogIXqT?=
 =?us-ascii?Q?8s/PlU3M2txjaMMIMPkRggydqAhK9i9WdiW/oq4GtWUNTk7qALAg1i5Ia2ZF?=
 =?us-ascii?Q?/wDmwdhqS2Rq4nqS8Wq27aV8mDKn21pi/lr3a6n7C08AYLR/NFwdbMl1dYrE?=
 =?us-ascii?Q?+QSXkJW3khcp0XkQO0BOhkT8PS3f1/MsTyj7JZQnuuSVCZq2oe6mp81p1Ddd?=
 =?us-ascii?Q?AGGRN1pm13rdoKFq1GFxdS+9ZhiGdViRrhQc8EOs3W3BHQxM06iSSjRfxYQP?=
 =?us-ascii?Q?F4DvQMZ6EA5KawjM4wdX9cys9M3ForSDqTMBQkrhOgrYktMxVf+/X0Nx7Zvc?=
 =?us-ascii?Q?28b7a1kGZGpUXLyOZYD0SH9b478CRz2IfbZ1rQrWELFU58gKHrFRusBCDr4J?=
 =?us-ascii?Q?GLSuHs6zUqq9FDX7wABiYWxC5nKSCeHu2HbsGMyQ8lQ/ZKxdoFTRgnckEwFE?=
 =?us-ascii?Q?LvSEKX6LckoXHJE2yf2vBZMYtMCf+fer7MZvfGYY/WRymw8KqoaBmJndCT7E?=
 =?us-ascii?Q?6lOgw2S1vjltdvBZqNwgRF53IR8x4aMxQ+jA9DSMux870JvhtooEzbgEsUNo?=
 =?us-ascii?Q?ZD9jp10rdsuLG9HMSG6EmLXFBsWSAoZLeKgVSSU4rOyRmisdM9JmxSL59+oJ?=
 =?us-ascii?Q?2AI2/krPBeHn6wBjDTeMX8Pew3iOMPsajqo0eZJFA1/TxiShe4loaqZaidlZ?=
 =?us-ascii?Q?wLYNdkAciQq5WWAM/L8EnWwGMFkT+nYQAnj/3+CY6+u1NAycHS9lTtwpk8/H?=
 =?us-ascii?Q?K9SnJ1Zb2SQBIh+vZeglHD3CtFBCCJ68uhYSLvjgoYc4YH73WUmTfEoTVcAI?=
 =?us-ascii?Q?TCnHpNoj+Q1AQK+1j7ELIWhsBLI9ZPQ4DHTIwDMZtvqNOztbgA8lj981mnlS?=
 =?us-ascii?Q?hjAHRD8xah7P47TJxtYV6pdje4Bcb8TMtb3lrB5hj240cT4lY3KflnD/xS9d?=
 =?us-ascii?Q?xl9Wxx86KVkUFg898cCOURXhB+pGc8IXk/cTyRuntQEg4QMFNgokZWqMoNy/?=
 =?us-ascii?Q?OuOjpVxQaD91LAgZRRWwunhcryKLSDDukuFQyXUI+0QPZGb79kM0Q0k5to0A?=
 =?us-ascii?Q?6DQpNeV4fVZ9E8CyQ0cPRrjC?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d44367f-a112-4e84-86ab-08d90e7ca11b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 21:44:29.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooQ4oz3XCDvPWnlSDoOweUv3IiDhNdVsm53YVTuEPCqeD7v0/dgvivVPWUGqrYVqdc1BC46VcXCPpqf1BhpFhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6201
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
a "soft" block, so it has many parameters which would not be
configurable in most hardware. This binding is usually automatically
generated by Xilinx's tools, so the names and values of properties
must be kept as they are.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml

diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
new file mode 100644
index 000000000000..3a0abd940336
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
+
+maintainers:
+  - Sean Anderson <sean.anderson@seco.com>
+
+properties:
+  compatible:
+    items:
+      - const: xlnx,axi-timer-2.0
+      - const: xlnx,xps-timer-1.00.a
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: s_axi_aclk
+
+  reg:
+    maxItems: 1
+
+  xlnx,count-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 32
+    description:
+      The width of the counters, in bits.
+
+  xlnx,gen0-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,gen1-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,one-timer-only:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      Whether only one timer is present in this block.
+
+  xlnx,trig0-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the capturetrig0 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,trig1-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the capturetrig1 signal. 0 for active-low, 1 for active-high.
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - xlnx,count-width
+  - xlnx,gen0-assert
+  - xlnx,gen1-assert
+  - xlnx,one-timer-only
+  - xlnx,trig0-assert
+  - xlnx,trig1-assert
+
+additionalProperties: true
+
+examples:
+  - |
+    axi_timer_0: timer@800e0000 {
+        clock-frequency = <99999001>;
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
+        reg = <0x0 0x800e0000 0x0 0x10000>;
+        xlnx,count-width = <0x20>;
+        xlnx,gen0-assert = <0x1>;
+        xlnx,gen1-assert = <0x1>;
+        xlnx,one-timer-only = <0x0>;
+        xlnx,trig0-assert = <0x1>;
+        xlnx,trig1-assert = <0x1>;
+    };
-- 
2.25.1

