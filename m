Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9B160740
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBPXcw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:32:52 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:49361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgBPXcw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojeyn0JdPJR+mypBp6uKcGE0+KFVeSKztFZ8Dq+vzy/nwh21Typ1Oydsqref4BEVSHK8aojeqFIw9WdgQTOmHdm5+ixayAnoGggbO44jQMeM0YdpEv1m7/Y5FM5lz2gYkSjz14YuwQnLTOfD7WKDFLCsIMNOhENnBMEcK4X9cb6wqsaJPmUMXlWB0WojWRNsQOAr+dQ9nftvShgn0JcKOPjt2ryKuZLUXPSArZA+KVY16L1b8K/JjPq+3YSF0UZtbfj52rWSS1r+ydIe1Velm+Rbvx2HDaybho1Moufod3UQthzdvlB/dj5v9hzNrcnULaF6FL1T6393FOOBfobo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj1Pw6rceDKu4McmYHFoNDbbac3tqW0jHwUmWMk+n5E=;
 b=Wdj221pYLptBZbFiz0/9+BMHcALZohJl0Ev+UvyB5J+5GhNcsJXkITHOMRNqsJ3mj5UPHb1dGA6WpZWIBE94shfMtbjT+vFd3R3ulXZb8X9u5IhDJUBEpsHtMSQPJ6OgzZvOsnAvLjNzCjtRA0CJ2n0ufmgpS8IbZ7Ptp7GtEjk9c9RFmPp4qDEgMqU52dzkeF8m82p05hl3KExgWMDgDSoSYnvzdXw9CPqJtIICrNbq75MzFx/Jo+0pBaP00htibnBS68uApowcHQQJ8NTmALsQSaRuxy6XdnHRB2fyHD6m6oIOxVWgQUO7gfJPTPlvdEKwkl+2VJpovCN93b0Vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj1Pw6rceDKu4McmYHFoNDbbac3tqW0jHwUmWMk+n5E=;
 b=lTRWtRmRBCwwNwmARx/7LquFqNrjGFyKcDZxPRJpMAOyImP4uabmKwUgYEBSVONPSWawaMBqukxPdkIiQ4q4jtuvOI4Nz8LGGcUKsHtbBpTaJI95CytfA7kDU9ooiXcdnZhVyPbH6Fvng+tfWxrtDhXkh1HQJH7HiC2o0NBa1XQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:32:42 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:32:42 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 2/7] mfd: Add support for Azoteq IQS620A/621/622/624/625
Date:   Sun, 16 Feb 2020 17:32:06 -0600
Message-Id: <1581895931-6056-3-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:32:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dee832f-b2ab-47b3-cd7c-08d7b33884a6
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB5406C8411106B8E73C1356AED3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(6486002)(36756003)(52116002)(508600001)(966005)(6512007)(2906002)(86362001)(30864003)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJ7bevaOyS/Z+2bB6eiy7q8cBk+eg+b//r9WM3HJjq55o8pLwpAAOWmdxXk8R32tPh5CtkfQsCr5LUlEmu0h1iqbXwtqcxaasLvzrENM4vu2yfs5g1cAmM4MG2rQAXj6Wvq0HCe6l/1DG6bi5qn5xjVUfL7u9scwhgfnCQnusoZlYro+9R9TEZx5wLftbmVmpCVxAVHq99NY6r/5Wa3flJtoidR+8U0fMPGkbgzVcQroIaZQFHNKcMw6+ALqI83kSFDJDn4GU/vp9jY6QSh4qyaqfaFgqjjttjKZKgIXyjX/pFrWQDSQ7my+MmGkyRtbO8Vbrw5xm7lq+x0SPRq0jXG4bh+OHzsMIF5kNmvqnwd2Rb1yZ7hDxBu3Nf2JTz7b4dpwt1FMX3EdrAls76BZV0BbpJq2OfASW0HFxOJsl+jkcLumQIBx6Oa5kmPKcRQf8CJajoTeeu3AsGqQUS7SjPMGRpMvnJ774c5O4GPNHXHvlXp4FjRnX7m+z3dvZzQyep1KXRcynezkNP6nrBw800bvevD9kHTS6sA70Hl01+azoe7+6ltJ6WNWqptMN1B/F7kGS0PExbl8M3rQVNuicoG2gmRJnF4R80HJSFocibohJaZgozIlMWfqvMPMZSEseBY/Cllo4/30zfd9urhFQg==
X-MS-Exchange-AntiSpam-MessageData: pCM1+o4DS158V6ZqbgOY3hb2FWhl9rQzPNNEHxx/EarAD4fb7/fig8RiZQ/cp/2YONvqeaEndbORifO+DHwRRyIP7ffhPEojWqQ4cODjFLfvONFjO6c352f/8iXJbu/LMNVDpOdGT+u44c4aFVPEiA==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dee832f-b2ab-47b3-cd7c-08d7b33884a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:32:42.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5qdYYyf9aFaKyFyNIbp5T0YOTtjwJGqmO5cEVWUKNW+QUNxdAn1VMAOd+sLluQBxzChCviHV8m1D7l7s9w7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds core support for the Azoteq IQS620A, IQS621, IQS622,
IQS624 and IQS625 multi-function sensors.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v5:
  - Merged iqs62x-core.c and iqs62x-tables.c into a single iqs62x.c
  - Corrected spelling of "data sheet" to "datasheet"
  - Added one line of whitespace in various places to improve readability
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Added the prox_settings member to the iqs62x_dev_desc struct and eliminated
    the ternary operator in iqs62x_dev_init to determine SAR UI enable register
    address
  - Added a comment in iqs62x_dev_init to explain the background for the bounds
    checking done on the IQS624/625 interval divider
  - Added #defines for the delays used within iqs62x_dev_init
  - Renamed iqs62x_fw_prs and iqs62x_fw_cb to iqs62x_firmware_parse and
    iqs62x_firmware_load, respectively
  - Updated the call to devm_mfd_add_devices to use PLATFORM_DEVID_NONE instead
    of -1 and printed "sub-devices" instead of "devices" in the error message
  - Dropped #defines for mfd_cell names in favor of the actual string names and
    collapsed mfd_cells with no other members into one line
  - Demoted iqs62x_devs to a static array as it is not used by any sub-devices
  - Removed unnecessary { IQS620A_DEV, ... } enum and IQS62X_NUM_DEV #define
  - Removed the soft reset and associated delay in iqs62x_probe to preserve any
    PWM-related changes made by a bootloader
  - Updated the comments in iqs62x_probe to highlight the significance of blank
    calibration registers and why the outer loop may be exited early
  - Made the first call to regmap_update_bits in iqs62x_suspend consistent with
    other instances in the series that set a single bit by passing all ones for
    the value instead of the mask

Changes in v4:
  - None

Changes in v3:
  - None

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Updated iqs62x_dev_init to account for 4/8/16-MHz clock divider in start-up
    delays and replaced ATI timeout routine with regmap_read_poll_timeout
  - Added an error message to iqs62x_irq in case device status fails to be read
  - Replaced sw_num member of iqs62x_core with a local variable in iqs62x_probe
    as the former was unused anywhere else
  - Added comments throughout iqs62x_probe to clarify how devices are matched
    based on the presence of calibration data
  - Inverted the product and software number comparison logic in iqs62x_probe
    to avoid an else...continue branch
  - Changed iqs62x_probe from .probe callback to .probe_new callback, thereby
    eliminating the otherwise unused iqs62x_id array
  - Moved iqs62x_suspend and iqs62x_resume below iqs62x_remove
  - Eliminated tabbed alignment of regmap_config and i2c_driver struct members
  - Added register definitions for register addresses used in iqs621_cal_regs,
    iqs620at_cal_regs and iqs62x_devs arrays
  - Removed of_compatible string from IQS622 mfd_cell struct as its proximity
    (now ambient light) sensing functionality need not be represented using a
    child node
  - Dissolved union in iqs62x_event_data to allow simultaneous use of ir_flags
    and als_flags
  - Removed temp_flags member of iqs62x_event_data, IQS62X_EVENT_TEMP register
    enumeration and IQS62X_EVENT_UI_HI/LO from iqs620a_event_regs (thereby re-
    ducing IQS62X_EVENT_SIZE to 10) as they were unused

 drivers/mfd/Kconfig        |   13 +
 drivers/mfd/Makefile       |    1 +
 drivers/mfd/iqs62x.c       | 1063 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/iqs62x.h |  139 ++++++
 4 files changed, 1216 insertions(+)
 create mode 100644 drivers/mfd/iqs62x.c
 create mode 100644 include/linux/mfd/iqs62x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b20329..daefcb6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -642,6 +642,19 @@ config MFD_IPAQ_MICRO
 	  AT90LS8535 microcontroller flashed with a special iPAQ
 	  firmware using the custom protocol implemented in this driver.

+config MFD_IQS62X
+	tristate "Azoteq IQS620A/621/622/624/625 core support"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build core support for the Azoteq IQS620A,
+	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors. Additional
+	  options must be selected to enable device-specific functions.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called iqs62x.
+
 config MFD_JANZ_CMODIO
 	tristate "Janz CMOD-IO PCI MODULbus Carrier Board"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b83f172..f935d10 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -226,6 +226,7 @@ obj-$(CONFIG_MFD_AS3711)	+= as3711.o
 obj-$(CONFIG_MFD_AS3722)	+= as3722.o
 obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
 obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
+obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
new file mode 100644
index 0000000..af764bc
--- /dev/null
+++ b/drivers/mfd/iqs62x.c
@@ -0,0 +1,1063 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ *
+ * These devices rely on application-specific register settings and calibration
+ * data developed in and exported from a suite of GUIs offered by the vendor. A
+ * separate tool converts the GUIs' ASCII-based output into a standard firmware
+ * file parsed by the driver.
+ *
+ * Link to datasheets and GUIs: https://www.azoteq.com/
+ *
+ * Link to conversion tool: https://github.com/jlabundy/iqs62x-h2bin.git
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#define IQS62X_PROD_NUM				0x00
+
+#define IQS62X_SYS_FLAGS			0x10
+#define IQS62X_SYS_FLAGS_IN_ATI			BIT(2)
+
+#define IQS620_HALL_FLAGS			0x16
+#define IQS621_HALL_FLAGS			0x19
+#define IQS622_HALL_FLAGS			IQS621_HALL_FLAGS
+
+#define IQS624_INTERVAL_NUM			0x18
+#define IQS625_INTERVAL_NUM			0x12
+
+#define IQS622_PROX_SETTINGS_4			0x48
+#define IQS620_PROX_SETTINGS_4			0x50
+#define IQS620_PROX_SETTINGS_4_SAR_EN		BIT(7)
+
+#define IQS621_ALS_CAL_DIV_LUX			0x82
+#define IQS621_ALS_CAL_DIV_IR			0x83
+
+#define IQS620_TEMP_CAL_MULT			0xC2
+#define IQS620_TEMP_CAL_DIV			0xC3
+#define IQS620_TEMP_CAL_OFFS			0xC4
+
+#define IQS62X_SYS_SETTINGS			0xD0
+#define IQS62X_SYS_SETTINGS_SOFT_RESET		BIT(7)
+#define IQS62X_SYS_SETTINGS_ACK_RESET		BIT(6)
+#define IQS62X_SYS_SETTINGS_EVENT_MODE		BIT(5)
+#define IQS62X_SYS_SETTINGS_CLK_DIV		BIT(4)
+#define IQS62X_SYS_SETTINGS_REDO_ATI		BIT(1)
+
+#define IQS62X_PWR_SETTINGS			0xD2
+#define IQS62X_PWR_SETTINGS_DIS_AUTO		BIT(5)
+#define IQS62X_PWR_SETTINGS_PWR_MODE_MASK	(BIT(4) | BIT(3))
+#define IQS62X_PWR_SETTINGS_PWR_MODE_HALT	(BIT(4) | BIT(3))
+#define IQS62X_PWR_SETTINGS_PWR_MODE_NORM	0
+
+#define IQS62X_OTP_CMD				0xF0
+#define IQS62X_OTP_CMD_FG3			0x13
+#define IQS62X_OTP_DATA				0xF1
+#define IQS62X_MAX_REG				0xFF
+
+#define IQS62X_HALL_CAL_MASK			GENMASK(3, 0)
+
+#define IQS62X_FW_REC_TYPE_INFO			0
+#define IQS62X_FW_REC_TYPE_PROD			1
+#define IQS62X_FW_REC_TYPE_HALL			2
+#define IQS62X_FW_REC_TYPE_MASK			3
+#define IQS62X_FW_REC_TYPE_DATA			4
+
+#define IQS62X_ATI_POLL_SLEEP_US		10000
+#define IQS62X_ATI_POLL_TIMEOUT_US		500000
+#define IQS62X_ATI_STABLE_DELAY_MS		150
+
+struct iqs62x_fw_rec {
+	u8 type;
+	u8 addr;
+	u8 len;
+	u8 data;
+} __packed;
+
+struct iqs62x_fw_blk {
+	struct list_head list;
+	u8 addr;
+	u8 mask;
+	u8 len;
+	u8 data[];
+};
+
+struct iqs62x_info {
+	u8 prod_num;
+	u8 sw_num;
+	u8 hw_num;
+} __packed;
+
+static int iqs62x_dev_init(struct iqs62x_core *iqs62x)
+{
+	struct iqs62x_fw_blk *fw_blk;
+	unsigned int val;
+	int ret;
+	u8 clk_div = 1;
+
+	list_for_each_entry(fw_blk, &iqs62x->fw_blk_head, list) {
+		if (fw_blk->mask)
+			ret = regmap_update_bits(iqs62x->regmap, fw_blk->addr,
+						 fw_blk->mask, *fw_blk->data);
+		else
+			ret = regmap_raw_write(iqs62x->regmap, fw_blk->addr,
+					       fw_blk->data, fw_blk->len);
+		if (ret)
+			return ret;
+	}
+
+	switch (iqs62x->dev_desc->prod_num) {
+	case IQS620_PROD_NUM:
+	case IQS622_PROD_NUM:
+		ret = regmap_read(iqs62x->regmap,
+				  iqs62x->dev_desc->prox_settings, &val);
+		if (ret)
+			return ret;
+
+		if (val & IQS620_PROX_SETTINGS_4_SAR_EN)
+			iqs62x->ui_sel = IQS62X_UI_SAR1;
+
+		/* fall through */
+
+	case IQS621_PROD_NUM:
+		ret = regmap_write(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+				   IQS620_GLBL_EVENT_MASK_PMU |
+				   iqs62x->dev_desc->prox_mask |
+				   iqs62x->dev_desc->sar_mask |
+				   iqs62x->dev_desc->hall_mask |
+				   iqs62x->dev_desc->hyst_mask |
+				   iqs62x->dev_desc->temp_mask |
+				   iqs62x->dev_desc->als_mask |
+				   iqs62x->dev_desc->ir_mask);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		ret = regmap_write(iqs62x->regmap, IQS624_HALL_UI,
+				   IQS624_HALL_UI_WHL_EVENT |
+				   IQS624_HALL_UI_INT_EVENT |
+				   IQS624_HALL_UI_AUTO_CAL);
+		if (ret)
+			return ret;
+
+		/*
+		 * The IQS625 default interval divider is below the minimum
+		 * permissible value, and the datasheet mandates that it is
+		 * corrected during initialization (unless an updated value
+		 * has already been provided by firmware).
+		 *
+		 * To protect against an unacceptably low user-entered value
+		 * stored in the firmware, the same check is extended to the
+		 * IQS624 as well.
+		 */
+		ret = regmap_read(iqs62x->regmap, IQS624_INTERVAL_DIV, &val);
+		if (ret)
+			return ret;
+
+		if (val >= iqs62x->dev_desc->interval_div)
+			break;
+
+		ret = regmap_write(iqs62x->regmap, IQS624_INTERVAL_DIV,
+				   iqs62x->dev_desc->interval_div);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(iqs62x->regmap, IQS62X_SYS_SETTINGS, &val);
+	if (ret)
+		return ret;
+
+	if (val & IQS62X_SYS_SETTINGS_CLK_DIV)
+		clk_div = iqs62x->dev_desc->clk_div;
+
+	ret = regmap_write(iqs62x->regmap, IQS62X_SYS_SETTINGS, val |
+			   IQS62X_SYS_SETTINGS_ACK_RESET |
+			   IQS62X_SYS_SETTINGS_EVENT_MODE |
+			   IQS62X_SYS_SETTINGS_REDO_ATI);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(iqs62x->regmap, IQS62X_SYS_FLAGS, val,
+				       !(val & IQS62X_SYS_FLAGS_IN_ATI),
+				       IQS62X_ATI_POLL_SLEEP_US,
+				       IQS62X_ATI_POLL_TIMEOUT_US * clk_div);
+	if (ret)
+		return ret;
+
+	msleep(IQS62X_ATI_STABLE_DELAY_MS * clk_div);
+
+	return 0;
+}
+
+static int iqs62x_firmware_parse(struct iqs62x_core *iqs62x,
+				 const struct firmware *fw)
+{
+	struct i2c_client *client = iqs62x->client;
+	struct iqs62x_fw_rec *fw_rec;
+	struct iqs62x_fw_blk *fw_blk;
+	unsigned int val;
+	size_t pos = 0;
+	int ret = 0;
+	u8 mask, len, *data;
+	u8 hall_cal_index = 0;
+
+	while (pos < fw->size) {
+		if (pos + sizeof(*fw_rec) > fw->size) {
+			ret = -EINVAL;
+			break;
+		}
+		fw_rec = (struct iqs62x_fw_rec *)(fw->data + pos);
+		pos += sizeof(*fw_rec);
+
+		if (pos + fw_rec->len - 1 > fw->size) {
+			ret = -EINVAL;
+			break;
+		}
+		pos += fw_rec->len - 1;
+
+		switch (fw_rec->type) {
+		case IQS62X_FW_REC_TYPE_INFO:
+			continue;
+
+		case IQS62X_FW_REC_TYPE_PROD:
+			if (fw_rec->data == iqs62x->dev_desc->prod_num)
+				continue;
+
+			dev_err(&client->dev,
+				"Incompatible product number: 0x%02X\n",
+				fw_rec->data);
+			ret = -EINVAL;
+			break;
+
+		case IQS62X_FW_REC_TYPE_HALL:
+			if (!hall_cal_index) {
+				ret = regmap_write(iqs62x->regmap,
+						   IQS62X_OTP_CMD,
+						   IQS62X_OTP_CMD_FG3);
+				if (ret)
+					break;
+
+				ret = regmap_read(iqs62x->regmap,
+						  IQS62X_OTP_DATA, &val);
+				if (ret)
+					break;
+
+				hall_cal_index = val & IQS62X_HALL_CAL_MASK;
+				if (!hall_cal_index) {
+					dev_err(&client->dev,
+						"Uncalibrated device\n");
+					ret = -ENODATA;
+					break;
+				}
+			}
+
+			if (hall_cal_index > fw_rec->len) {
+				ret = -EINVAL;
+				break;
+			}
+
+			mask = 0;
+			data = &fw_rec->data + hall_cal_index - 1;
+			len = sizeof(*data);
+			break;
+
+		case IQS62X_FW_REC_TYPE_MASK:
+			if (fw_rec->len < (sizeof(mask) + sizeof(*data))) {
+				ret = -EINVAL;
+				break;
+			}
+
+			mask = fw_rec->data;
+			data = &fw_rec->data + sizeof(mask);
+			len = sizeof(*data);
+			break;
+
+		case IQS62X_FW_REC_TYPE_DATA:
+			mask = 0;
+			data = &fw_rec->data;
+			len = fw_rec->len;
+			break;
+
+		default:
+			dev_err(&client->dev,
+				"Unrecognized record type: 0x%02X\n",
+				fw_rec->type);
+			ret = -EINVAL;
+		}
+
+		if (ret)
+			break;
+
+		fw_blk = devm_kzalloc(&client->dev,
+				      struct_size(fw_blk, data, len),
+				      GFP_KERNEL);
+		if (!fw_blk) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		fw_blk->addr = fw_rec->addr;
+		fw_blk->mask = mask;
+		fw_blk->len = len;
+		memcpy(fw_blk->data, data, len);
+
+		list_add(&fw_blk->list, &iqs62x->fw_blk_head);
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS] = {
+	[IQS62X_EVENT_PROX_CH0_T] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(4),
+		.val	= BIT(4),
+	},
+	[IQS62X_EVENT_PROX_CH0_P] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(0),
+		.val	= BIT(0),
+	},
+	[IQS62X_EVENT_PROX_CH1_T] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(5),
+		.val	= BIT(5),
+	},
+	[IQS62X_EVENT_PROX_CH1_P] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(1),
+		.val	= BIT(1),
+	},
+	[IQS62X_EVENT_PROX_CH2_T] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(6),
+		.val	= BIT(6),
+	},
+	[IQS62X_EVENT_PROX_CH2_P] = {
+		.reg	= IQS62X_EVENT_PROX,
+		.mask	= BIT(2),
+		.val	= BIT(2),
+	},
+	[IQS62X_EVENT_HYST_POS_T] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(6) | BIT(7),
+		.val	= BIT(6),
+	},
+	[IQS62X_EVENT_HYST_POS_P] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(5) | BIT(7),
+		.val	= BIT(5),
+	},
+	[IQS62X_EVENT_HYST_NEG_T] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(6) | BIT(7),
+		.val	= BIT(6) | BIT(7),
+	},
+	[IQS62X_EVENT_HYST_NEG_P] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(5) | BIT(7),
+		.val	= BIT(5) | BIT(7),
+	},
+	[IQS62X_EVENT_SAR1_ACT] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(4),
+		.val	= BIT(4),
+	},
+	[IQS62X_EVENT_SAR1_QRD] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(2),
+		.val	= BIT(2),
+	},
+	[IQS62X_EVENT_SAR1_MOVE] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(1),
+		.val	= BIT(1),
+	},
+	[IQS62X_EVENT_SAR1_HALT] = {
+		.reg	= IQS62X_EVENT_HYST,
+		.mask	= BIT(0),
+		.val	= BIT(0),
+	},
+	[IQS62X_EVENT_WHEEL_UP] = {
+		.reg	= IQS62X_EVENT_WHEEL,
+		.mask	= BIT(7) | BIT(6),
+		.val	= BIT(7),
+	},
+	[IQS62X_EVENT_WHEEL_DN] = {
+		.reg	= IQS62X_EVENT_WHEEL,
+		.mask	= BIT(7) | BIT(6),
+		.val	= BIT(7) | BIT(6),
+	},
+	[IQS62X_EVENT_HALL_N_T] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(2) | BIT(0),
+		.val	= BIT(2),
+	},
+	[IQS62X_EVENT_HALL_N_P] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(1) | BIT(0),
+		.val	= BIT(1),
+	},
+	[IQS62X_EVENT_HALL_S_T] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(2) | BIT(0),
+		.val	= BIT(2) | BIT(0),
+	},
+	[IQS62X_EVENT_HALL_S_P] = {
+		.reg	= IQS62X_EVENT_HALL,
+		.mask	= BIT(1) | BIT(0),
+		.val	= BIT(1) | BIT(0),
+	},
+	[IQS62X_EVENT_SYS_RESET] = {
+		.reg	= IQS62X_EVENT_SYS,
+		.mask	= BIT(7),
+		.val	= BIT(7),
+	},
+};
+EXPORT_SYMBOL_GPL(iqs62x_events);
+
+static irqreturn_t iqs62x_irq(int irq, void *context)
+{
+	struct iqs62x_core *iqs62x = context;
+	struct i2c_client *client = iqs62x->client;
+	struct iqs62x_event_data event_data;
+	struct iqs62x_event_desc event_desc;
+	enum iqs62x_event_reg event_reg;
+	unsigned long event_flags = 0;
+	int ret, i, j;
+	u8 event_map[IQS62X_EVENT_SIZE];
+
+	/*
+	 * The device asserts the RDY output to signal the beginning of a
+	 * communication window, which is closed by an I2C stop condition.
+	 * As such, all interrupt status is captured in a single read and
+	 * broadcast to any interested sub-device drivers.
+	 */
+	ret = regmap_raw_read(iqs62x->regmap, IQS62X_SYS_FLAGS, event_map,
+			      sizeof(event_map));
+	if (ret) {
+		dev_err(&client->dev, "Failed to read device status: %d\n",
+			ret);
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < sizeof(event_map); i++) {
+		event_reg = iqs62x->dev_desc->event_regs[iqs62x->ui_sel][i];
+
+		switch (event_reg) {
+		case IQS62X_EVENT_UI_LO:
+			event_data.ui_data = get_unaligned_le16(&event_map[i]);
+
+			/* fall through */
+
+		case IQS62X_EVENT_UI_HI:
+		case IQS62X_EVENT_NONE:
+			continue;
+
+		case IQS62X_EVENT_ALS:
+			event_data.als_flags = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_IR:
+			event_data.ir_flags = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_INTER:
+			event_data.interval = event_map[i];
+			continue;
+
+		case IQS62X_EVENT_HYST:
+			event_map[i] <<= iqs62x->dev_desc->hyst_shift;
+
+			/* fall through */
+
+		case IQS62X_EVENT_WHEEL:
+		case IQS62X_EVENT_HALL:
+		case IQS62X_EVENT_PROX:
+		case IQS62X_EVENT_SYS:
+			break;
+		}
+
+		for (j = 0; j < IQS62X_NUM_EVENTS; j++) {
+			event_desc = iqs62x_events[j];
+
+			if (event_desc.reg != event_reg)
+				continue;
+
+			if ((event_map[i] & event_desc.mask) == event_desc.val)
+				event_flags |= BIT(j);
+		}
+	}
+
+	/*
+	 * The device resets itself in response to the I2C master stalling
+	 * communication past a fixed timeout. In this case, all registers
+	 * are restored and any interested sub-device drivers are notified.
+	 */
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		dev_err(&client->dev, "Unexpected device reset\n");
+
+		ret = iqs62x_dev_init(iqs62x);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to re-initialize device: %d\n", ret);
+			return IRQ_NONE;
+		}
+	}
+
+	ret = blocking_notifier_call_chain(&iqs62x->nh, event_flags,
+					   &event_data);
+	if (ret & NOTIFY_STOP_MASK)
+		return IRQ_NONE;
+
+	/*
+	 * Once the communication window is closed, a small delay is added to
+	 * ensure the device's RDY output has been deasserted by the time the
+	 * interrupt handler returns.
+	 */
+	usleep_range(50, 100);
+
+	return IRQ_HANDLED;
+}
+
+static void iqs62x_firmware_load(const struct firmware *fw, void *context)
+{
+	struct iqs62x_core *iqs62x = context;
+	struct i2c_client *client = iqs62x->client;
+	int ret;
+
+	if (fw) {
+		ret = iqs62x_firmware_parse(iqs62x, fw);
+		if (ret) {
+			dev_err(&client->dev, "Failed to parse firmware: %d\n",
+				ret);
+			goto err_out;
+		}
+	}
+
+	ret = iqs62x_dev_init(iqs62x);
+	if (ret) {
+		dev_err(&client->dev, "Failed to initialize device: %d\n", ret);
+		goto err_out;
+	}
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, iqs62x_irq, IRQF_ONESHOT,
+					client->name, iqs62x);
+	if (ret) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
+		goto err_out;
+	}
+
+	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
+				   iqs62x->dev_desc->sub_devs,
+				   iqs62x->dev_desc->num_sub_devs,
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(&client->dev, "Failed to add sub-devices: %d\n", ret);
+
+err_out:
+	complete_all(&iqs62x->fw_done);
+}
+
+static const struct mfd_cell iqs620at_sub_devs[] = {
+	{
+		.name = "iqs62x-keys",
+		.of_compatible = "azoteq,iqs620a-keys",
+	},
+	{
+		.name = "iqs620a-pwm",
+		.of_compatible = "azoteq,iqs620a-pwm",
+	},
+	{ .name = "iqs620at-temp", },
+};
+
+static const struct mfd_cell iqs620a_sub_devs[] = {
+	{
+		.name = "iqs62x-keys",
+		.of_compatible = "azoteq,iqs620a-keys",
+	},
+	{
+		.name = "iqs620a-pwm",
+		.of_compatible = "azoteq,iqs620a-pwm",
+	},
+};
+
+static const struct mfd_cell iqs621_sub_devs[] = {
+	{
+		.name = "iqs62x-keys",
+		.of_compatible = "azoteq,iqs621-keys",
+	},
+	{ .name = "iqs621-als", },
+};
+
+static const struct mfd_cell iqs622_sub_devs[] = {
+	{
+		.name = "iqs62x-keys",
+		.of_compatible = "azoteq,iqs622-keys",
+	},
+	{ .name = "iqs621-als", },
+};
+
+static const struct mfd_cell iqs624_sub_devs[] = {
+	{
+		.name = "iqs62x-keys",
+		.of_compatible = "azoteq,iqs624-keys",
+	},
+	{ .name = "iqs624-pos", },
+};
+
+static const struct mfd_cell iqs625_sub_devs[] = {
+	{
+		.name = "iqs62x-keys",
+		.of_compatible = "azoteq,iqs625-keys",
+	},
+	{ .name = "iqs624-pos", },
+};
+
+static const u8 iqs620at_cal_regs[] = {
+	IQS620_TEMP_CAL_MULT,
+	IQS620_TEMP_CAL_DIV,
+	IQS620_TEMP_CAL_OFFS,
+};
+
+static const u8 iqs621_cal_regs[] = {
+	IQS621_ALS_CAL_DIV_LUX,
+	IQS621_ALS_CAL_DIV_IR,
+};
+
+static const enum iqs62x_event_reg iqs620a_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HALL,	/* 0x16 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+	[IQS62X_UI_SAR1] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HALL,	/* 0x16 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+};
+
+static const enum iqs62x_event_reg iqs621_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_ALS,	/* 0x16 */
+		IQS62X_EVENT_UI_LO,	/* 0x17 */
+		IQS62X_EVENT_UI_HI,	/* 0x18 */
+		IQS62X_EVENT_HALL,	/* 0x19 */
+	},
+};
+
+static const enum iqs62x_event_reg iqs622_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_ALS,	/* 0x14 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_IR,	/* 0x16 */
+		IQS62X_EVENT_UI_LO,	/* 0x17 */
+		IQS62X_EVENT_UI_HI,	/* 0x18 */
+		IQS62X_EVENT_HALL,	/* 0x19 */
+	},
+	[IQS62X_UI_SAR1] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_HYST,	/* 0x13 */
+		IQS62X_EVENT_ALS,	/* 0x14 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_IR,	/* 0x16 */
+		IQS62X_EVENT_UI_LO,	/* 0x17 */
+		IQS62X_EVENT_UI_HI,	/* 0x18 */
+		IQS62X_EVENT_HALL,	/* 0x19 */
+	},
+};
+
+static const enum iqs62x_event_reg iqs624_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_PROX,	/* 0x12 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_WHEEL,	/* 0x14 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_UI_LO,	/* 0x16 */
+		IQS62X_EVENT_UI_HI,	/* 0x17 */
+		IQS62X_EVENT_INTER,	/* 0x18 */
+		IQS62X_EVENT_NONE,
+	},
+};
+
+static const enum iqs62x_event_reg iqs625_event_regs[][IQS62X_EVENT_SIZE] = {
+	[IQS62X_UI_PROX] = {
+		IQS62X_EVENT_SYS,	/* 0x10 */
+		IQS62X_EVENT_PROX,	/* 0x11 */
+		IQS62X_EVENT_INTER,	/* 0x12 */
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+		IQS62X_EVENT_NONE,
+	},
+};
+
+static const struct iqs62x_dev_desc iqs62x_devs[] = {
+	{
+		.dev_name	= "iqs620at",
+		.sub_devs	= iqs620at_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs620at_sub_devs),
+
+		.prod_num	= IQS620_PROD_NUM,
+		.sw_num		= 0x08,
+		.cal_regs	= iqs620at_cal_regs,
+		.num_cal_regs	= ARRAY_SIZE(iqs620at_cal_regs),
+
+		.prox_mask	= BIT(0),
+		.sar_mask	= BIT(1) | BIT(7),
+		.hall_mask	= BIT(2),
+		.hyst_mask	= BIT(3),
+		.temp_mask	= BIT(4),
+
+		.prox_settings	= IQS620_PROX_SETTINGS_4,
+		.hall_flags	= IQS620_HALL_FLAGS,
+
+		.clk_div	= 4,
+		.fw_name	= "iqs620a.bin",
+		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
+	},
+	{
+		.dev_name	= "iqs620a",
+		.sub_devs	= iqs620a_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs620a_sub_devs),
+
+		.prod_num	= IQS620_PROD_NUM,
+		.sw_num		= 0x08,
+
+		.prox_mask	= BIT(0),
+		.sar_mask	= BIT(1) | BIT(7),
+		.hall_mask	= BIT(2),
+		.hyst_mask	= BIT(3),
+		.temp_mask	= BIT(4),
+
+		.prox_settings	= IQS620_PROX_SETTINGS_4,
+		.hall_flags	= IQS620_HALL_FLAGS,
+
+		.clk_div	= 4,
+		.fw_name	= "iqs620a.bin",
+		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
+	},
+	{
+		.dev_name	= "iqs621",
+		.sub_devs	= iqs621_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs621_sub_devs),
+
+		.prod_num	= IQS621_PROD_NUM,
+		.sw_num		= 0x09,
+		.cal_regs	= iqs621_cal_regs,
+		.num_cal_regs	= ARRAY_SIZE(iqs621_cal_regs),
+
+		.prox_mask	= BIT(0),
+		.hall_mask	= BIT(1),
+		.als_mask	= BIT(2),
+		.hyst_mask	= BIT(3),
+		.temp_mask	= BIT(4),
+
+		.als_flags	= IQS621_ALS_FLAGS,
+		.hall_flags	= IQS621_HALL_FLAGS,
+		.hyst_shift	= 5,
+
+		.clk_div	= 2,
+		.fw_name	= "iqs621.bin",
+		.event_regs	= &iqs621_event_regs[IQS62X_UI_PROX],
+	},
+	{
+		.dev_name	= "iqs622",
+		.sub_devs	= iqs622_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs622_sub_devs),
+
+		.prod_num	= IQS622_PROD_NUM,
+		.sw_num		= 0x06,
+
+		.prox_mask	= BIT(0),
+		.sar_mask	= BIT(1),
+		.hall_mask	= BIT(2),
+		.als_mask	= BIT(3),
+		.ir_mask	= BIT(4),
+
+		.prox_settings	= IQS622_PROX_SETTINGS_4,
+		.als_flags	= IQS622_ALS_FLAGS,
+		.hall_flags	= IQS622_HALL_FLAGS,
+
+		.clk_div	= 2,
+		.fw_name	= "iqs622.bin",
+		.event_regs	= &iqs622_event_regs[IQS62X_UI_PROX],
+	},
+	{
+		.dev_name	= "iqs624",
+		.sub_devs	= iqs624_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs624_sub_devs),
+
+		.prod_num	= IQS624_PROD_NUM,
+		.sw_num		= 0x0B,
+
+		.interval	= IQS624_INTERVAL_NUM,
+		.interval_div	= 3,
+
+		.clk_div	= 2,
+		.fw_name	= "iqs624.bin",
+		.event_regs	= &iqs624_event_regs[IQS62X_UI_PROX],
+	},
+	{
+		.dev_name	= "iqs625",
+		.sub_devs	= iqs625_sub_devs,
+		.num_sub_devs	= ARRAY_SIZE(iqs625_sub_devs),
+
+		.prod_num	= IQS625_PROD_NUM,
+		.sw_num		= 0x0B,
+
+		.interval	= IQS625_INTERVAL_NUM,
+		.interval_div	= 10,
+
+		.clk_div	= 2,
+		.fw_name	= "iqs625.bin",
+		.event_regs	= &iqs625_event_regs[IQS62X_UI_PROX],
+	},
+};
+
+static const struct regmap_config iqs62x_map_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = IQS62X_MAX_REG,
+};
+
+static int iqs62x_probe(struct i2c_client *client)
+{
+	struct iqs62x_core *iqs62x;
+	struct iqs62x_info info;
+	unsigned int val;
+	int ret, i, j;
+	u8 sw_num = 0;
+	const char *fw_name = NULL;
+
+	iqs62x = devm_kzalloc(&client->dev, sizeof(*iqs62x), GFP_KERNEL);
+	if (!iqs62x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, iqs62x);
+	iqs62x->client = client;
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
+	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
+	init_completion(&iqs62x->fw_done);
+
+	iqs62x->regmap = devm_regmap_init_i2c(client, &iqs62x_map_config);
+	if (IS_ERR(iqs62x->regmap)) {
+		ret = PTR_ERR(iqs62x->regmap);
+		dev_err(&client->dev, "Failed to initialize register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = regmap_raw_read(iqs62x->regmap, IQS62X_PROD_NUM, &info,
+			      sizeof(info));
+	if (ret)
+		return ret;
+
+	/*
+	 * The following sequence validates the device's product and software
+	 * numbers. It then determines if the device is factory-calibrated by
+	 * checking for nonzero values in the device's designated calibration
+	 * registers (if applicable). Depending on the device, the absence of
+	 * calibration data indicates a reduced feature set or invalid device.
+	 *
+	 * For devices given in both calibrated and uncalibrated versions, the
+	 * calibrated version (e.g. IQS620AT) appears first in the iqs62x_devs
+	 * array. The uncalibrated version (e.g. IQS620A) appears next and has
+	 * the same product and software numbers, but no calibration registers
+	 * are specified.
+	 */
+	for (i = 0; i < ARRAY_SIZE(iqs62x_devs); i++) {
+		if (info.prod_num != iqs62x_devs[i].prod_num)
+			continue;
+
+		iqs62x->dev_desc = &iqs62x_devs[i];
+
+		if (info.sw_num < iqs62x->dev_desc->sw_num)
+			continue;
+
+		sw_num = info.sw_num;
+
+		/*
+		 * Read each of the device's designated calibration registers,
+		 * if any, and exit from the inner loop early if any are equal
+		 * to zero (indicating the device is uncalibrated). This could
+		 * be acceptable depending on the device (e.g. IQS620A instead
+		 * of IQS620AT).
+		 */
+		for (j = 0; j < iqs62x->dev_desc->num_cal_regs; j++) {
+			ret = regmap_read(iqs62x->regmap,
+					  iqs62x->dev_desc->cal_regs[j], &val);
+			if (ret)
+				return ret;
+
+			if (!val)
+				break;
+		}
+
+		/*
+		 * If the number of nonzero values read from the device equals
+		 * the number of designated calibration registers (which could
+		 * be zero), exit from the outer loop early to signal that the
+		 * device's product and software numbers match a known device,
+		 * and the device is calibrated (if applicable).
+		 */
+		if (j == iqs62x->dev_desc->num_cal_regs)
+			break;
+	}
+
+	if (!iqs62x->dev_desc) {
+		dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
+			info.prod_num);
+		return -EINVAL;
+	}
+
+	if (!sw_num) {
+		dev_err(&client->dev, "Unrecognized software number: 0x%02X\n",
+			info.sw_num);
+		return -EINVAL;
+	}
+
+	if (i == ARRAY_SIZE(iqs62x_devs)) {
+		dev_err(&client->dev, "Uncalibrated device\n");
+		return -ENODATA;
+	}
+
+	device_property_read_string(&client->dev, "firmware-name", &fw_name);
+
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				      fw_name ? : iqs62x->dev_desc->fw_name,
+				      &client->dev, GFP_KERNEL, iqs62x,
+				      iqs62x_firmware_load);
+	if (ret)
+		dev_err(&client->dev, "Failed to request firmware: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs62x_remove(struct i2c_client *client)
+{
+	struct iqs62x_core *iqs62x = i2c_get_clientdata(client);
+
+	wait_for_completion(&iqs62x->fw_done);
+
+	return 0;
+}
+
+static int __maybe_unused iqs62x_suspend(struct device *dev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
+	int ret;
+
+	wait_for_completion(&iqs62x->fw_done);
+
+	/*
+	 * As per the datasheet, automatic mode switching must be disabled
+	 * before the device is placed in or taken out of halt mode.
+	 */
+	ret = regmap_update_bits(iqs62x->regmap, IQS62X_PWR_SETTINGS,
+				 IQS62X_PWR_SETTINGS_DIS_AUTO, 0xFF);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(iqs62x->regmap, IQS62X_PWR_SETTINGS,
+				  IQS62X_PWR_SETTINGS_PWR_MODE_MASK,
+				  IQS62X_PWR_SETTINGS_PWR_MODE_HALT);
+}
+
+static int __maybe_unused iqs62x_resume(struct device *dev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(iqs62x->regmap, IQS62X_PWR_SETTINGS,
+				 IQS62X_PWR_SETTINGS_PWR_MODE_MASK,
+				 IQS62X_PWR_SETTINGS_PWR_MODE_NORM);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(iqs62x->regmap, IQS62X_PWR_SETTINGS,
+				  IQS62X_PWR_SETTINGS_DIS_AUTO, 0);
+}
+
+static SIMPLE_DEV_PM_OPS(iqs62x_pm, iqs62x_suspend, iqs62x_resume);
+
+static const struct of_device_id iqs62x_of_match[] = {
+	{ .compatible = "azoteq,iqs620a" },
+	{ .compatible = "azoteq,iqs621" },
+	{ .compatible = "azoteq,iqs622" },
+	{ .compatible = "azoteq,iqs624" },
+	{ .compatible = "azoteq,iqs625" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, iqs62x_of_match);
+
+static struct i2c_driver iqs62x_i2c_driver = {
+	.driver = {
+		.name = "iqs62x",
+		.of_match_table = iqs62x_of_match,
+		.pm = &iqs62x_pm,
+	},
+	.probe_new = iqs62x_probe,
+	.remove = iqs62x_remove,
+};
+module_i2c_driver(iqs62x_i2c_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Multi-Function Sensors");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
new file mode 100644
index 0000000..043d3b6
--- /dev/null
+++ b/include/linux/mfd/iqs62x.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#ifndef __LINUX_MFD_IQS62X_H
+#define __LINUX_MFD_IQS62X_H
+
+#define IQS620_PROD_NUM				0x41
+#define IQS621_PROD_NUM				0x46
+#define IQS622_PROD_NUM				0x42
+#define IQS624_PROD_NUM				0x43
+#define IQS625_PROD_NUM				0x4E
+
+#define IQS621_ALS_FLAGS			0x16
+#define IQS622_ALS_FLAGS			0x14
+
+#define IQS624_HALL_UI				0x70
+#define IQS624_HALL_UI_WHL_EVENT		BIT(4)
+#define IQS624_HALL_UI_INT_EVENT		BIT(3)
+#define IQS624_HALL_UI_AUTO_CAL			BIT(2)
+
+#define IQS624_INTERVAL_DIV			0x7D
+
+#define IQS620_GLBL_EVENT_MASK			0xD7
+#define IQS620_GLBL_EVENT_MASK_PMU		BIT(6)
+
+#define IQS62X_NUM_KEYS				16
+#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 5)
+
+#define IQS62X_EVENT_SIZE			10
+
+enum iqs62x_ui_sel {
+	IQS62X_UI_PROX,
+	IQS62X_UI_SAR1,
+};
+
+enum iqs62x_event_reg {
+	IQS62X_EVENT_NONE,
+	IQS62X_EVENT_SYS,
+	IQS62X_EVENT_PROX,
+	IQS62X_EVENT_HYST,
+	IQS62X_EVENT_HALL,
+	IQS62X_EVENT_ALS,
+	IQS62X_EVENT_IR,
+	IQS62X_EVENT_WHEEL,
+	IQS62X_EVENT_INTER,
+	IQS62X_EVENT_UI_LO,
+	IQS62X_EVENT_UI_HI,
+};
+
+enum iqs62x_event_flag {
+	/* keys */
+	IQS62X_EVENT_PROX_CH0_T,
+	IQS62X_EVENT_PROX_CH0_P,
+	IQS62X_EVENT_PROX_CH1_T,
+	IQS62X_EVENT_PROX_CH1_P,
+	IQS62X_EVENT_PROX_CH2_T,
+	IQS62X_EVENT_PROX_CH2_P,
+	IQS62X_EVENT_HYST_POS_T,
+	IQS62X_EVENT_HYST_POS_P,
+	IQS62X_EVENT_HYST_NEG_T,
+	IQS62X_EVENT_HYST_NEG_P,
+	IQS62X_EVENT_SAR1_ACT,
+	IQS62X_EVENT_SAR1_QRD,
+	IQS62X_EVENT_SAR1_MOVE,
+	IQS62X_EVENT_SAR1_HALT,
+	IQS62X_EVENT_WHEEL_UP,
+	IQS62X_EVENT_WHEEL_DN,
+
+	/* switches */
+	IQS62X_EVENT_HALL_N_T,
+	IQS62X_EVENT_HALL_N_P,
+	IQS62X_EVENT_HALL_S_T,
+	IQS62X_EVENT_HALL_S_P,
+
+	/* everything else */
+	IQS62X_EVENT_SYS_RESET,
+};
+
+struct iqs62x_event_data {
+	u16 ui_data;
+	u8 als_flags;
+	u8 ir_flags;
+	u8 interval;
+};
+
+struct iqs62x_event_desc {
+	enum iqs62x_event_reg reg;
+	u8 mask;
+	u8 val;
+};
+
+struct iqs62x_dev_desc {
+	const char *dev_name;
+	const struct mfd_cell *sub_devs;
+	int num_sub_devs;
+
+	u8 prod_num;
+	u8 sw_num;
+	const u8 *cal_regs;
+	int num_cal_regs;
+
+	u8 prox_mask;
+	u8 sar_mask;
+	u8 hall_mask;
+	u8 hyst_mask;
+	u8 temp_mask;
+	u8 als_mask;
+	u8 ir_mask;
+
+	u8 prox_settings;
+	u8 als_flags;
+	u8 hall_flags;
+	u8 hyst_shift;
+
+	u8 interval;
+	u8 interval_div;
+
+	u8 clk_div;
+	const char *fw_name;
+	const enum iqs62x_event_reg (*event_regs)[IQS62X_EVENT_SIZE];
+};
+
+struct iqs62x_core {
+	const struct iqs62x_dev_desc *dev_desc;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct blocking_notifier_head nh;
+	struct list_head fw_blk_head;
+	struct completion fw_done;
+	enum iqs62x_ui_sel ui_sel;
+};
+
+extern const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS];
+
+#endif /* __LINUX_MFD_IQS62X_H */
--
2.7.4

