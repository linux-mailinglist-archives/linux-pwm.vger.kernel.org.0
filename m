Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046891401F6
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 03:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbgAQCfk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 21:35:40 -0500
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:41966
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729113AbgAQCfj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 21:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLocS+jghrhkKA3snpWdS/OELa1gEnfHH/DIn+hvIUSg4khxr+vaVZfEr6fWT1qQBfNs6f3Y1tBZpgY64IF41cSd4cR7Bu5w6dNHpj3lEoIRb49IiFAMqfe7Pw2APFzWfpQQqFrFzMF8XT4VNd3mtiSH59rJQRl7+0rZ0ElUBH9hgGRmhxF86QPWx7IW/trdasx/t5fAO9pMcAgqomfqun1dMK/8UbeTVAEB5Q6mK1MjeNOrETxGMHsONFCuZcZQjLSpmjaNb9ec6OqvmuLwzEJyKaO2mNSzJ/3AkoQMOLmFqOPvq25nwzQR+sgfJYhCdiVKuMR6t/BwolCZVQUTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEZ9erQtqHvSgbCB2gz43cm9bHw+NHsyvsImJghJYNs=;
 b=RcDEi5q3I6a9scfE0LZrdo+xF26zWn+HnggYj3TZS4VbhpjkpbfVuxDqRIXlaybWfUw/Zqzsv/wsA7mYcy7gIp07Zar9gesa1QEi6WbQb/qZzS4adOAe2nwSRDvZ3Emm78EIw3D3fqK8i8fYpysPgI3dTp2kZuRpGsf7pMGv5KMze8hR+F9e6m735/ntKNdcGzYC2LiYbm3+PUJpX6PxhvK2A1DGcEWMQArKjI2VdmXzBxlXGEem8atNHT4I8Ph9eEG93u2///Fuxnh4Wj/+HIXM/FSNP4+mnpO1HiT8NhnQ3G7GeCFUyE5XhGsatEAlBXohwGVmNQLCaxsDBiJupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEZ9erQtqHvSgbCB2gz43cm9bHw+NHsyvsImJghJYNs=;
 b=GdG6J/A21yCT2D17Aeie/Mh5Of+BM59TKc+Bg/yVDKyYtJNvKw1N+OjZd8ngMjwsEEK8PXfdrIiU9t0upsNIKereV6LRcBwgfyqSYPqnpSJJWS4Q3ofAIQ0sf9OmlnUtdanqfEalwqDnAtsQK+I/BX+9nZ4048p6MiKDo/DpKCU=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4671.namprd08.prod.outlook.com (52.135.117.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 02:35:34 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 02:35:34 +0000
Received: from localhost.localdomain (136.49.227.119) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Fri, 17 Jan 2020 02:35:25 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v4 2/7] mfd: Add support for Azoteq IQS620A/621/622/624/625
Thread-Topic: [PATCH v4 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVzN7LS9UVe3hXOEa6+dol5orE9Q==
Date:   Fri, 17 Jan 2020 02:35:34 +0000
Message-ID: <1579228475-6681-3-git-send-email-jeff@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1579228475-6681-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9789ca4-1f69-4ecb-c663-08d79af5ec89
x-ms-traffictypediagnostic: SN6PR08MB4671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB46719ACF37ABAD03DCDEFE3DD3310@SN6PR08MB4671.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34096005)(396003)(136003)(376002)(346002)(366004)(39830400003)(189003)(199004)(64756008)(66946007)(66556008)(66476007)(107886003)(4326008)(69590400006)(2616005)(186003)(956004)(52116002)(66446008)(6506007)(71200400001)(5660300002)(30864003)(6666004)(16526019)(36756003)(6512007)(7416002)(966005)(54906003)(316002)(26005)(508600001)(81166006)(8676002)(6486002)(110136005)(86362001)(2906002)(8936002)(81156014)(461764006)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4671;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6UUrQQCYbAFmu6rGsPgZ1EgaKdD3uMadOLj5GTDLVrIU4T404e8L4TiATv488yl968/+1ns6PWEs73akmOEFF+0AxW2mBMqnbsSZvtzPl0Bl5wjMFJYOMdMb8GPOP7MyKf5KAqoTVCjgzNZiSe+xsp3hjqxIoCfS7ZSRdG9P27pSgn3QViKVjVvZGfpjlCcrvDPT3V6Ydoq/LOqQBMlPnoUPtPTlxchFTwArlHIqBPSxDEHmzZlShEpF7XJzXgxSMiMtgPvQQ1I204WFR9dI6jytHOBulc0Uc5U2fmVUxvAIK872Kx50ZRPPd91QwauBzSpLnIE0znird13Kga+eoF/htIkNcEQ0VJB1oY2xBfRq+wiBEiLIN344Z4aCkVoVRc88qGQEhvx26wDojXJ23Q1TLYNTb9CbXcpfAzWJINozm55L3EWjoQVWI9X1tOJhAUokrdoXtCcPSg/ioQB7Fa7NNqDdDMNV6totjQT57jxTKAtprbSvLDEf04QDcZx8fnRzzxBXwVMaAh8Z+pdnyV6/H0jmDIObszx/qkNNDShTjelius9z74P7TepBxZnXIAyhIw/FNPXs6jLZqUBDA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9789ca4-1f69-4ecb-c663-08d79af5ec89
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:35:34.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gV0DbMxgmlJN6rbd0kT7F3OZK5S+M3rskbryYkBIZY83YnmTDQYC4ynVRlaQ+pfocKwUFDsV3l6u0CVXcuaEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4671
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds core support for the Azoteq IQS620A, IQS621, IQS622,
IQS624 and IQS625 multi-function sensors.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v4:
  - None

Changes in v3:
  - None

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Updated iqs62x_dev_init to account for 4/8/16-MHz clock divider in star=
t-up
    delays and replaced ATI timeout routine with regmap_read_poll_timeout
  - Added an error message to iqs62x_irq in case device status fails to be =
read
  - Replaced sw_num member of iqs62x_core with a local variable in iqs62x_p=
robe
    as the former was unused anywhere else
  - Added comments throughout iqs62x_probe to clarify how devices are match=
ed
    based on the presence of calibration data
  - Inverted the product and software number comparison logic in iqs62x_pro=
be
    to avoid an else...continue branch
  - Changed iqs62x_probe from .probe callback to .probe_new callback, there=
by
    eliminating the otherwise unused iqs62x_id array
  - Moved iqs62x_suspend and iqs62x_resume below iqs62x_remove
  - Eliminated tabbed alignment of regmap_config and i2c_driver struct memb=
ers
  - Added register definitions for register addresses used in iqs621_cal_re=
gs,
    iqs620at_cal_regs and iqs62x_devs arrays
  - Removed of_compatible string from IQS622 mfd_cell struct as its proximi=
ty
    (now ambient light) sensing functionality need not be represented using=
 a
    child node
  - Dissolved union in iqs62x_event_data to allow simultaneous use of ir_fl=
ags
    and als_flags
  - Removed temp_flags member of iqs62x_event_data, IQS62X_EVENT_TEMP regis=
ter
    enumeration and IQS62X_EVENT_UI_HI/LO from iqs620a_event_regs (thereby =
re-
    ducing IQS62X_EVENT_SIZE to 10) as they were unused

 drivers/mfd/Kconfig         |  13 +
 drivers/mfd/Makefile        |   3 +
 drivers/mfd/iqs62x-core.c   | 639 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/mfd/iqs62x-tables.c | 438 ++++++++++++++++++++++++++++++
 include/linux/mfd/iqs62x.h  | 146 ++++++++++
 5 files changed, 1239 insertions(+)
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 include/linux/mfd/iqs62x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4209008..151984c 100644
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
index aed99f0..c4fc26b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -232,6 +232,9 @@ obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
 obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+=3D sky81452.o

+iqs62x-objs			:=3D iqs62x-core.o iqs62x-tables.o
+obj-$(CONFIG_MFD_IQS62X)	+=3D iqs62x.o
+
 intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
 obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+=3D intel_soc_pmic_bxtwc.o
diff --git a/drivers/mfd/iqs62x-core.c b/drivers/mfd/iqs62x-core.c
new file mode 100644
index 0000000..767f9d8
--- /dev/null
+++ b/drivers/mfd/iqs62x-core.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ *
+ * These devices rely on application-specific register settings and calibr=
ation
+ * data developed in and exported from a suite of GUIs offered by the vend=
or. A
+ * separate tool converts the GUIs' ASCII-based output into a standard fir=
mware
+ * file parsed by the driver.
+ *
+ * Link to data sheets and GUIs: https://www.azoteq.com/
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
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#include <linux/mfd/iqs62x.h>
+
+#define IQS62X_PROD_NUM				0x00
+
+#define IQS62X_SYS_FLAGS			0x10
+#define IQS62X_SYS_FLAGS_IN_ATI			BIT(2)
+
+#define IQS622_PROX_SETTINGS_4			0x48
+#define IQS620_PROX_SETTINGS_4			0x50
+#define IQS620_PROX_SETTINGS_4_SAR_EN		BIT(7)
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
+	u8 clk_div =3D 1;
+
+	list_for_each_entry(fw_blk, &iqs62x->fw_blk_head, list) {
+		if (fw_blk->mask)
+			ret =3D regmap_update_bits(iqs62x->map, fw_blk->addr,
+						 fw_blk->mask, *fw_blk->data);
+		else
+			ret =3D regmap_raw_write(iqs62x->map, fw_blk->addr,
+					       fw_blk->data, fw_blk->len);
+		if (ret)
+			return ret;
+	}
+
+	switch (iqs62x->dev_desc->prod_num) {
+	case IQS620_PROD_NUM:
+	case IQS622_PROD_NUM:
+		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->prod_num =3D=3D
+				  IQS620_PROD_NUM ? IQS620_PROX_SETTINGS_4 :
+						    IQS622_PROX_SETTINGS_4,
+				  &val);
+		if (ret)
+			return ret;
+
+		if (val & IQS620_PROX_SETTINGS_4_SAR_EN)
+			iqs62x->ui_sel =3D IQS62X_UI_SAR1;
+		/* fall through */
+
+	case IQS621_PROD_NUM:
+		ret =3D regmap_write(iqs62x->map, IQS620_GLBL_EVENT_MASK,
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
+		ret =3D regmap_write(iqs62x->map, IQS624_HALL_UI,
+				   IQS624_HALL_UI_WHL_EVENT |
+				   IQS624_HALL_UI_INT_EVENT |
+				   IQS624_HALL_UI_AUTO_CAL);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_read(iqs62x->map, IQS624_INTERVAL_DIV, &val);
+		if (ret)
+			return ret;
+
+		if (val >=3D iqs62x->dev_desc->interval_div)
+			break;
+
+		ret =3D regmap_write(iqs62x->map, IQS624_INTERVAL_DIV,
+				   iqs62x->dev_desc->interval_div);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D regmap_read(iqs62x->map, IQS62X_SYS_SETTINGS, &val);
+	if (ret)
+		return ret;
+
+	if (val & IQS62X_SYS_SETTINGS_CLK_DIV)
+		clk_div =3D iqs62x->dev_desc->clk_div;
+
+	ret =3D regmap_write(iqs62x->map, IQS62X_SYS_SETTINGS, val |
+			   IQS62X_SYS_SETTINGS_ACK_RESET |
+			   IQS62X_SYS_SETTINGS_EVENT_MODE |
+			   IQS62X_SYS_SETTINGS_REDO_ATI);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read_poll_timeout(iqs62x->map, IQS62X_SYS_FLAGS, val,
+				       !(val & IQS62X_SYS_FLAGS_IN_ATI),
+				       10000, clk_div * 500000);
+	if (ret)
+		return ret;
+
+	/*
+	 * The following delay accommodates the post-ATI stabilization time
+	 * specified in the data sheet (with additional margin).
+	 */
+	msleep(clk_div * 150);
+
+	return 0;
+}
+
+static int iqs62x_fw_prs(struct iqs62x_core *iqs62x, const struct firmware=
 *fw)
+{
+	struct i2c_client *client =3D iqs62x->client;
+	struct iqs62x_fw_rec *fw_rec;
+	struct iqs62x_fw_blk *fw_blk;
+	unsigned int val;
+	size_t pos =3D 0;
+	int ret =3D 0;
+	u8 mask, len, *data;
+	u8 hall_cal_index =3D 0;
+
+	while (pos < fw->size) {
+		if (pos + sizeof(*fw_rec) > fw->size) {
+			ret =3D -EINVAL;
+			break;
+		}
+		fw_rec =3D (struct iqs62x_fw_rec *)(fw->data + pos);
+		pos +=3D sizeof(*fw_rec);
+
+		if (pos + fw_rec->len - 1 > fw->size) {
+			ret =3D -EINVAL;
+			break;
+		}
+		pos +=3D fw_rec->len - 1;
+
+		switch (fw_rec->type) {
+		case IQS62X_FW_REC_TYPE_INFO:
+			continue;
+
+		case IQS62X_FW_REC_TYPE_PROD:
+			if (fw_rec->data =3D=3D iqs62x->dev_desc->prod_num)
+				continue;
+
+			dev_err(&client->dev,
+				"Incompatible product number: 0x%02X\n",
+				fw_rec->data);
+			ret =3D -EINVAL;
+			break;
+
+		case IQS62X_FW_REC_TYPE_HALL:
+			if (!hall_cal_index) {
+				ret =3D regmap_write(iqs62x->map, IQS62X_OTP_CMD,
+						   IQS62X_OTP_CMD_FG3);
+				if (ret)
+					break;
+
+				ret =3D regmap_read(iqs62x->map, IQS62X_OTP_DATA,
+						  &val);
+				if (ret)
+					break;
+
+				hall_cal_index =3D val & IQS62X_HALL_CAL_MASK;
+				if (!hall_cal_index) {
+					dev_err(&client->dev,
+						"Uncalibrated device\n");
+					ret =3D -ENODATA;
+					break;
+				}
+			}
+
+			if (hall_cal_index > fw_rec->len) {
+				ret =3D -EINVAL;
+				break;
+			}
+
+			mask =3D 0;
+			data =3D &fw_rec->data + hall_cal_index - 1;
+			len =3D sizeof(*data);
+			break;
+
+		case IQS62X_FW_REC_TYPE_MASK:
+			if (fw_rec->len < (sizeof(mask) + sizeof(*data))) {
+				ret =3D -EINVAL;
+				break;
+			}
+
+			mask =3D fw_rec->data;
+			data =3D &fw_rec->data + sizeof(mask);
+			len =3D sizeof(*data);
+			break;
+
+		case IQS62X_FW_REC_TYPE_DATA:
+			mask =3D 0;
+			data =3D &fw_rec->data;
+			len =3D fw_rec->len;
+			break;
+
+		default:
+			dev_err(&client->dev,
+				"Unrecognized record type: 0x%02X\n",
+				fw_rec->type);
+			ret =3D -EINVAL;
+		}
+
+		if (ret)
+			break;
+
+		fw_blk =3D devm_kzalloc(&client->dev,
+				      struct_size(fw_blk, data, len),
+				      GFP_KERNEL);
+		if (!fw_blk) {
+			ret =3D -ENOMEM;
+			break;
+		}
+
+		fw_blk->addr =3D fw_rec->addr;
+		fw_blk->mask =3D mask;
+		fw_blk->len =3D len;
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
+static irqreturn_t iqs62x_irq(int irq, void *context)
+{
+	struct iqs62x_core *iqs62x =3D context;
+	struct i2c_client *client =3D iqs62x->client;
+	struct iqs62x_event_data event_data;
+	struct iqs62x_event_desc event_desc;
+	enum iqs62x_event_reg event_reg;
+	unsigned long event_flags =3D 0;
+	int ret, i, j;
+	u8 event_map[IQS62X_EVENT_SIZE];
+
+	/*
+	 * The device asserts the RDY output to signal the beginning of a
+	 * communication window, which is closed by an I2C stop condition.
+	 * As such, all interrupt status is captured in a single read and
+	 * broadcast to any interested sub-device drivers.
+	 */
+	ret =3D regmap_raw_read(iqs62x->map, IQS62X_SYS_FLAGS, event_map,
+			      sizeof(event_map));
+	if (ret) {
+		dev_err(&client->dev, "Failed to read device status: %d\n",
+			ret);
+		return IRQ_NONE;
+	}
+
+	for (i =3D 0; i < sizeof(event_map); i++) {
+		event_reg =3D iqs62x->dev_desc->event_regs[iqs62x->ui_sel][i];
+
+		switch (event_reg) {
+		case IQS62X_EVENT_UI_LO:
+			event_data.ui_data =3D get_unaligned_le16(&event_map[i]);
+			/* fall through */
+		case IQS62X_EVENT_UI_HI:
+		case IQS62X_EVENT_NONE:
+			continue;
+
+		case IQS62X_EVENT_ALS:
+			event_data.als_flags =3D event_map[i];
+			continue;
+
+		case IQS62X_EVENT_IR:
+			event_data.ir_flags =3D event_map[i];
+			continue;
+
+		case IQS62X_EVENT_INTER:
+			event_data.interval =3D event_map[i];
+			continue;
+
+		case IQS62X_EVENT_HYST:
+			event_map[i] <<=3D iqs62x->dev_desc->hyst_shift;
+			/* fall through */
+		case IQS62X_EVENT_WHEEL:
+		case IQS62X_EVENT_HALL:
+		case IQS62X_EVENT_PROX:
+		case IQS62X_EVENT_SYS:
+			break;
+		}
+
+		for (j =3D 0; j < IQS62X_NUM_EVENTS; j++) {
+			event_desc =3D iqs62x_events[j];
+
+			if (event_desc.reg !=3D event_reg)
+				continue;
+
+			if ((event_map[i] & event_desc.mask) =3D=3D event_desc.val)
+				event_flags |=3D BIT(j);
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
+		ret =3D iqs62x_dev_init(iqs62x);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to re-initialize device: %d\n", ret);
+			return IRQ_NONE;
+		}
+	}
+
+	ret =3D blocking_notifier_call_chain(&iqs62x->nh, event_flags,
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
+static void iqs62x_fw_cb(const struct firmware *fw, void *context)
+{
+	struct iqs62x_core *iqs62x =3D context;
+	struct i2c_client *client =3D iqs62x->client;
+	int ret;
+
+	if (fw) {
+		ret =3D iqs62x_fw_prs(iqs62x, fw);
+		if (ret) {
+			dev_err(&client->dev, "Failed to parse firmware: %d\n",
+				ret);
+			goto err_out;
+		}
+	}
+
+	ret =3D iqs62x_dev_init(iqs62x);
+	if (ret) {
+		dev_err(&client->dev, "Failed to initialize device: %d\n", ret);
+		goto err_out;
+	}
+
+	ret =3D devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, iqs62x_irq, IRQF_ONESHOT,
+					client->name, iqs62x);
+	if (ret) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
+		goto err_out;
+	}
+
+	ret =3D devm_mfd_add_devices(&client->dev, -1,
+				   iqs62x->dev_desc->sub_devs,
+				   iqs62x->dev_desc->num_sub_devs,
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(&client->dev, "Failed to add devices: %d\n", ret);
+
+err_out:
+	complete_all(&iqs62x->fw_done);
+}
+
+static const struct regmap_config iqs62x_map_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D IQS62X_MAX_REG,
+};
+
+static int iqs62x_probe(struct i2c_client *client)
+{
+	struct iqs62x_core *iqs62x;
+	struct iqs62x_info info;
+	unsigned int val;
+	int ret, i, j;
+	u8 sw_num =3D 0;
+	const char *fw_name =3D NULL;
+
+	iqs62x =3D devm_kzalloc(&client->dev, sizeof(*iqs62x), GFP_KERNEL);
+	if (!iqs62x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, iqs62x);
+	iqs62x->client =3D client;
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
+	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
+	init_completion(&iqs62x->fw_done);
+
+	iqs62x->map =3D devm_regmap_init_i2c(client, &iqs62x_map_config);
+	if (IS_ERR(iqs62x->map)) {
+		ret =3D PTR_ERR(iqs62x->map);
+		dev_err(&client->dev, "Failed to initialize register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret =3D regmap_raw_read(iqs62x->map, IQS62X_PROD_NUM, &info,
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
+	for (i =3D 0; i < IQS62X_NUM_DEV; i++) {
+		if (info.prod_num !=3D iqs62x_devs[i].prod_num)
+			continue;
+		iqs62x->dev_desc =3D &iqs62x_devs[i];
+
+		if (info.sw_num < iqs62x->dev_desc->sw_num)
+			continue;
+		sw_num =3D info.sw_num;
+
+		/*
+		 * Read each of the device's designated calibration registers,
+		 * if any, and exit from the inner loop early if any are equal
+		 * to zero.
+		 */
+		for (j =3D 0; j < iqs62x->dev_desc->num_cal_regs; j++) {
+			ret =3D regmap_read(iqs62x->map,
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
+		 * be zero), exit from the outer loop early to signal a device
+		 * has been matched.
+		 */
+		if (j =3D=3D iqs62x->dev_desc->num_cal_regs)
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
+	if (i =3D=3D IQS62X_NUM_DEV) {
+		dev_err(&client->dev, "Uncalibrated device\n");
+		return -ENODATA;
+	}
+
+	ret =3D regmap_write(iqs62x->map, IQS62X_SYS_SETTINGS,
+			   IQS62X_SYS_SETTINGS_SOFT_RESET);
+	if (ret)
+		return ret;
+	usleep_range(10000, 10100);
+
+	device_property_read_string(&client->dev, "firmware-name", &fw_name);
+
+	ret =3D request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				      fw_name ? : iqs62x->dev_desc->fw_name,
+				      &client->dev, GFP_KERNEL, iqs62x,
+				      iqs62x_fw_cb);
+	if (ret)
+		dev_err(&client->dev, "Failed to request firmware: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs62x_remove(struct i2c_client *client)
+{
+	struct iqs62x_core *iqs62x =3D i2c_get_clientdata(client);
+
+	wait_for_completion(&iqs62x->fw_done);
+
+	return 0;
+}
+
+static int __maybe_unused iqs62x_suspend(struct device *dev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(dev);
+	int ret;
+
+	wait_for_completion(&iqs62x->fw_done);
+
+	/*
+	 * As per the data sheet, automatic mode switching must be disabled
+	 * before the device is placed in or taken out of halt mode.
+	 */
+	ret =3D regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				 IQS62X_PWR_SETTINGS_DIS_AUTO,
+				 IQS62X_PWR_SETTINGS_DIS_AUTO);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				  IQS62X_PWR_SETTINGS_PWR_MODE_MASK,
+				  IQS62X_PWR_SETTINGS_PWR_MODE_HALT);
+}
+
+static int __maybe_unused iqs62x_resume(struct device *dev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				 IQS62X_PWR_SETTINGS_PWR_MODE_MASK,
+				 IQS62X_PWR_SETTINGS_PWR_MODE_NORM);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(iqs62x->map, IQS62X_PWR_SETTINGS,
+				  IQS62X_PWR_SETTINGS_DIS_AUTO, 0);
+}
+
+static SIMPLE_DEV_PM_OPS(iqs62x_pm, iqs62x_suspend, iqs62x_resume);
+
+static const struct of_device_id iqs62x_of_match[] =3D {
+	{ .compatible =3D "azoteq,iqs620a" },
+	{ .compatible =3D "azoteq,iqs621" },
+	{ .compatible =3D "azoteq,iqs622" },
+	{ .compatible =3D "azoteq,iqs624" },
+	{ .compatible =3D "azoteq,iqs625" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, iqs62x_of_match);
+
+static struct i2c_driver iqs62x_i2c_driver =3D {
+	.driver =3D {
+		.name =3D "iqs62x",
+		.of_match_table =3D iqs62x_of_match,
+		.pm =3D &iqs62x_pm,
+	},
+	.probe_new =3D iqs62x_probe,
+	.remove =3D iqs62x_remove,
+};
+module_i2c_driver(iqs62x_i2c_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Multi-Function Sensors"=
);
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/iqs62x-tables.c b/drivers/mfd/iqs62x-tables.c
new file mode 100644
index 0000000..580f6ac
--- /dev/null
+++ b/drivers/mfd/iqs62x-tables.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/iqs62x.h>
+
+#define IQS620_HALL_FLAGS			0x16
+#define IQS620_TEMP_CAL_MULT			0xC2
+#define IQS620_TEMP_CAL_DIV			0xC3
+#define IQS620_TEMP_CAL_OFFS			0xC4
+
+#define IQS621_HALL_FLAGS			0x19
+#define IQS621_ALS_CAL_DIV_LUX			0x82
+#define IQS621_ALS_CAL_DIV_IR			0x83
+
+#define IQS622_HALL_FLAGS			IQS621_HALL_FLAGS
+
+#define IQS624_INTERVAL_NUM			0x18
+#define IQS625_INTERVAL_NUM			0x12
+
+static const struct mfd_cell iqs620at_sub_devs[] =3D {
+	{
+		.name =3D IQS62X_DRV_NAME_KEYS,
+		.of_compatible =3D "azoteq,iqs620a-keys",
+	},
+	{
+		.name =3D IQS620_DRV_NAME_PWM,
+		.of_compatible =3D "azoteq,iqs620a-pwm",
+	},
+	{
+		.name =3D IQS620_DRV_NAME_TEMP,
+	},
+};
+
+static const struct mfd_cell iqs620a_sub_devs[] =3D {
+	{
+		.name =3D IQS62X_DRV_NAME_KEYS,
+		.of_compatible =3D "azoteq,iqs620a-keys",
+	},
+	{
+		.name =3D IQS620_DRV_NAME_PWM,
+		.of_compatible =3D "azoteq,iqs620a-pwm",
+	},
+};
+
+static const struct mfd_cell iqs621_sub_devs[] =3D {
+	{
+		.name =3D IQS62X_DRV_NAME_KEYS,
+		.of_compatible =3D "azoteq,iqs621-keys",
+	},
+	{
+		.name =3D IQS621_DRV_NAME_ALS,
+	},
+};
+
+static const struct mfd_cell iqs622_sub_devs[] =3D {
+	{
+		.name =3D IQS62X_DRV_NAME_KEYS,
+		.of_compatible =3D "azoteq,iqs622-keys",
+	},
+	{
+		.name =3D IQS621_DRV_NAME_ALS,
+	},
+};
+
+static const struct mfd_cell iqs624_sub_devs[] =3D {
+	{
+		.name =3D IQS62X_DRV_NAME_KEYS,
+		.of_compatible =3D "azoteq,iqs624-keys",
+	},
+	{
+		.name =3D IQS624_DRV_NAME_POS,
+	},
+};
+
+static const struct mfd_cell iqs625_sub_devs[] =3D {
+	{
+		.name =3D IQS62X_DRV_NAME_KEYS,
+		.of_compatible =3D "azoteq,iqs625-keys",
+	},
+	{
+		.name =3D IQS624_DRV_NAME_POS,
+	},
+};
+
+static const u8 iqs620at_cal_regs[] =3D {
+	IQS620_TEMP_CAL_MULT,
+	IQS620_TEMP_CAL_DIV,
+	IQS620_TEMP_CAL_OFFS,
+};
+
+static const u8 iqs621_cal_regs[] =3D {
+	IQS621_ALS_CAL_DIV_LUX,
+	IQS621_ALS_CAL_DIV_IR,
+};
+
+static const enum iqs62x_event_reg iqs620a_event_regs[][IQS62X_EVENT_SIZE]=
 =3D {
+	[IQS62X_UI_PROX] =3D {
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
+	[IQS62X_UI_SAR1] =3D {
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
+static const enum iqs62x_event_reg iqs621_event_regs[][IQS62X_EVENT_SIZE] =
=3D {
+	[IQS62X_UI_PROX] =3D {
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
+static const enum iqs62x_event_reg iqs622_event_regs[][IQS62X_EVENT_SIZE] =
=3D {
+	[IQS62X_UI_PROX] =3D {
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
+	[IQS62X_UI_SAR1] =3D {
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
+static const enum iqs62x_event_reg iqs624_event_regs[][IQS62X_EVENT_SIZE] =
=3D {
+	[IQS62X_UI_PROX] =3D {
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
+static const enum iqs62x_event_reg iqs625_event_regs[][IQS62X_EVENT_SIZE] =
=3D {
+	[IQS62X_UI_PROX] =3D {
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
+enum {
+	IQS620AT_DEV,
+	IQS620A_DEV,
+	IQS621_DEV,
+	IQS622_DEV,
+	IQS624_DEV,
+	IQS625_DEV,
+};
+
+const struct iqs62x_dev_desc iqs62x_devs[IQS62X_NUM_DEV] =3D {
+	[IQS620AT_DEV] =3D {
+		.dev_name	=3D "iqs620at",
+		.sub_devs	=3D iqs620at_sub_devs,
+		.num_sub_devs	=3D ARRAY_SIZE(iqs620at_sub_devs),
+
+		.prod_num	=3D IQS620_PROD_NUM,
+		.sw_num		=3D 0x08,
+		.cal_regs	=3D iqs620at_cal_regs,
+		.num_cal_regs	=3D ARRAY_SIZE(iqs620at_cal_regs),
+
+		.prox_mask	=3D BIT(0),
+		.sar_mask	=3D BIT(1) | BIT(7),
+		.hall_mask	=3D BIT(2),
+		.hyst_mask	=3D BIT(3),
+		.temp_mask	=3D BIT(4),
+
+		.hall_flags	=3D IQS620_HALL_FLAGS,
+
+		.clk_div	=3D 4,
+		.fw_name	=3D "iqs620a.bin",
+		.event_regs	=3D &iqs620a_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS620A_DEV] =3D {
+		.dev_name	=3D "iqs620a",
+		.sub_devs	=3D iqs620a_sub_devs,
+		.num_sub_devs	=3D ARRAY_SIZE(iqs620a_sub_devs),
+
+		.prod_num	=3D IQS620_PROD_NUM,
+		.sw_num		=3D 0x08,
+
+		.prox_mask	=3D BIT(0),
+		.sar_mask	=3D BIT(1) | BIT(7),
+		.hall_mask	=3D BIT(2),
+		.hyst_mask	=3D BIT(3),
+		.temp_mask	=3D BIT(4),
+
+		.hall_flags	=3D IQS620_HALL_FLAGS,
+
+		.clk_div	=3D 4,
+		.fw_name	=3D "iqs620a.bin",
+		.event_regs	=3D &iqs620a_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS621_DEV] =3D {
+		.dev_name	=3D "iqs621",
+		.sub_devs	=3D iqs621_sub_devs,
+		.num_sub_devs	=3D ARRAY_SIZE(iqs621_sub_devs),
+
+		.prod_num	=3D IQS621_PROD_NUM,
+		.sw_num		=3D 0x09,
+		.cal_regs	=3D iqs621_cal_regs,
+		.num_cal_regs	=3D ARRAY_SIZE(iqs621_cal_regs),
+
+		.prox_mask	=3D BIT(0),
+		.hall_mask	=3D BIT(1),
+		.als_mask	=3D BIT(2),
+		.hyst_mask	=3D BIT(3),
+		.temp_mask	=3D BIT(4),
+
+		.als_flags	=3D IQS621_ALS_FLAGS,
+		.hall_flags	=3D IQS621_HALL_FLAGS,
+		.hyst_shift	=3D 5,
+
+		.clk_div	=3D 2,
+		.fw_name	=3D "iqs621.bin",
+		.event_regs	=3D &iqs621_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS622_DEV] =3D {
+		.dev_name	=3D "iqs622",
+		.sub_devs	=3D iqs622_sub_devs,
+		.num_sub_devs	=3D ARRAY_SIZE(iqs622_sub_devs),
+
+		.prod_num	=3D IQS622_PROD_NUM,
+		.sw_num		=3D 0x06,
+
+		.prox_mask	=3D BIT(0),
+		.sar_mask	=3D BIT(1),
+		.hall_mask	=3D BIT(2),
+		.als_mask	=3D BIT(3),
+		.ir_mask	=3D BIT(4),
+
+		.als_flags	=3D IQS622_ALS_FLAGS,
+		.hall_flags	=3D IQS622_HALL_FLAGS,
+
+		.clk_div	=3D 2,
+		.fw_name	=3D "iqs622.bin",
+		.event_regs	=3D &iqs622_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS624_DEV] =3D {
+		.dev_name	=3D "iqs624",
+		.sub_devs	=3D iqs624_sub_devs,
+		.num_sub_devs	=3D ARRAY_SIZE(iqs624_sub_devs),
+
+		.prod_num	=3D IQS624_PROD_NUM,
+		.sw_num		=3D 0x0B,
+
+		.interval	=3D IQS624_INTERVAL_NUM,
+		.interval_div	=3D 3,
+
+		.clk_div	=3D 2,
+		.fw_name	=3D "iqs624.bin",
+		.event_regs	=3D &iqs624_event_regs[IQS62X_UI_PROX],
+	},
+	[IQS625_DEV] =3D {
+		.dev_name	=3D "iqs625",
+		.sub_devs	=3D iqs625_sub_devs,
+		.num_sub_devs	=3D ARRAY_SIZE(iqs625_sub_devs),
+
+		.prod_num	=3D IQS625_PROD_NUM,
+		.sw_num		=3D 0x0B,
+
+		.interval	=3D IQS625_INTERVAL_NUM,
+		.interval_div	=3D 10,
+
+		.clk_div	=3D 2,
+		.fw_name	=3D "iqs625.bin",
+		.event_regs	=3D &iqs625_event_regs[IQS62X_UI_PROX],
+	},
+};
+EXPORT_SYMBOL_GPL(iqs62x_devs);
+
+const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS] =3D {
+	[IQS62X_EVENT_PROX_CH0_T] =3D {
+		.reg	=3D IQS62X_EVENT_PROX,
+		.mask	=3D BIT(4),
+		.val	=3D BIT(4),
+	},
+	[IQS62X_EVENT_PROX_CH0_P] =3D {
+		.reg	=3D IQS62X_EVENT_PROX,
+		.mask	=3D BIT(0),
+		.val	=3D BIT(0),
+	},
+	[IQS62X_EVENT_PROX_CH1_T] =3D {
+		.reg	=3D IQS62X_EVENT_PROX,
+		.mask	=3D BIT(5),
+		.val	=3D BIT(5),
+	},
+	[IQS62X_EVENT_PROX_CH1_P] =3D {
+		.reg	=3D IQS62X_EVENT_PROX,
+		.mask	=3D BIT(1),
+		.val	=3D BIT(1),
+	},
+	[IQS62X_EVENT_PROX_CH2_T] =3D {
+		.reg	=3D IQS62X_EVENT_PROX,
+		.mask	=3D BIT(6),
+		.val	=3D BIT(6),
+	},
+	[IQS62X_EVENT_PROX_CH2_P] =3D {
+		.reg	=3D IQS62X_EVENT_PROX,
+		.mask	=3D BIT(2),
+		.val	=3D BIT(2),
+	},
+	[IQS62X_EVENT_HYST_POS_T] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(6) | BIT(7),
+		.val	=3D BIT(6),
+	},
+	[IQS62X_EVENT_HYST_POS_P] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(5) | BIT(7),
+		.val	=3D BIT(5),
+	},
+	[IQS62X_EVENT_HYST_NEG_T] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(6) | BIT(7),
+		.val	=3D BIT(6) | BIT(7),
+	},
+	[IQS62X_EVENT_HYST_NEG_P] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(5) | BIT(7),
+		.val	=3D BIT(5) | BIT(7),
+	},
+	[IQS62X_EVENT_SAR1_ACT] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(4),
+		.val	=3D BIT(4),
+	},
+	[IQS62X_EVENT_SAR1_QRD] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(2),
+		.val	=3D BIT(2),
+	},
+	[IQS62X_EVENT_SAR1_MOVE] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(1),
+		.val	=3D BIT(1),
+	},
+	[IQS62X_EVENT_SAR1_HALT] =3D {
+		.reg	=3D IQS62X_EVENT_HYST,
+		.mask	=3D BIT(0),
+		.val	=3D BIT(0),
+	},
+	[IQS62X_EVENT_WHEEL_UP] =3D {
+		.reg	=3D IQS62X_EVENT_WHEEL,
+		.mask	=3D BIT(7) | BIT(6),
+		.val	=3D BIT(7),
+	},
+	[IQS62X_EVENT_WHEEL_DN] =3D {
+		.reg	=3D IQS62X_EVENT_WHEEL,
+		.mask	=3D BIT(7) | BIT(6),
+		.val	=3D BIT(7) | BIT(6),
+	},
+	[IQS62X_EVENT_HALL_N_T] =3D {
+		.reg	=3D IQS62X_EVENT_HALL,
+		.mask	=3D BIT(2) | BIT(0),
+		.val	=3D BIT(2),
+	},
+	[IQS62X_EVENT_HALL_N_P] =3D {
+		.reg	=3D IQS62X_EVENT_HALL,
+		.mask	=3D BIT(1) | BIT(0),
+		.val	=3D BIT(1),
+	},
+	[IQS62X_EVENT_HALL_S_T] =3D {
+		.reg	=3D IQS62X_EVENT_HALL,
+		.mask	=3D BIT(2) | BIT(0),
+		.val	=3D BIT(2) | BIT(0),
+	},
+	[IQS62X_EVENT_HALL_S_P] =3D {
+		.reg	=3D IQS62X_EVENT_HALL,
+		.mask	=3D BIT(1) | BIT(0),
+		.val	=3D BIT(1) | BIT(0),
+	},
+	[IQS62X_EVENT_SYS_RESET] =3D {
+		.reg	=3D IQS62X_EVENT_SYS,
+		.mask	=3D BIT(7),
+		.val	=3D BIT(7),
+	},
+};
+EXPORT_SYMBOL_GPL(iqs62x_events);
diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
new file mode 100644
index 0000000..0dc5997
--- /dev/null
+++ b/include/linux/mfd/iqs62x.h
@@ -0,0 +1,146 @@
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
+#define IQS62X_NUM_DEV				6
+#define IQS62X_NUM_KEYS				16
+#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 5)
+
+#define IQS62X_EVENT_SIZE			10
+
+#define IQS62X_DRV_NAME_KEYS			"iqs62x-keys"
+#define IQS620_DRV_NAME_TEMP			"iqs620at-temp"
+#define IQS620_DRV_NAME_PWM			"iqs620a-pwm"
+#define IQS621_DRV_NAME_ALS			"iqs621-als"
+#define IQS624_DRV_NAME_POS			"iqs624-pos"
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
+	struct regmap *map;
+	struct blocking_notifier_head nh;
+	struct list_head fw_blk_head;
+	struct completion fw_done;
+	enum iqs62x_ui_sel ui_sel;
+};
+
+extern const struct iqs62x_dev_desc iqs62x_devs[IQS62X_NUM_DEV];
+extern const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS];
+
+#endif /* __LINUX_MFD_IQS62X_H */
--
2.7.4

