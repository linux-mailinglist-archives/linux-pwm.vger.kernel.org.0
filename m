Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5814020D
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 03:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbgAQCgg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 21:36:36 -0500
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:7136
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387791AbgAQCgf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 21:36:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlUDBvHJlXroSNgO9rBvwomKCOGHXBfGNMWJvCheH3kZkI67ysXdj8/PXcmrVki40IFLwKpNeErZzcYh+ljBpsGtPWEF5e+NrO/wMjuDwQfinLqUGjdaaI8Tz5cRwprOJRVlmelcr1Jy9k+ifW7ldfNzr2t7UdJOPXx4wZGiPWI5Je1+//is1yRA09n5cNPso6aLTFDxyto5DXlj5vj7TQLKLbnYJNzCj1CB+0TxlB2VuccASOkxHtqny8hMF8dygUN085qKKFZf1LKTFylRbjuha1Njo4FDfqlTVMRcrhVth7B+XtjmYuKHv5Ltnh3uuA17aDHTRRpd8nGrLYeeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeea6ZuF9JagJOyK0dFRDgMm6uuldMveKjEriL5+MGY=;
 b=HH2Jtzj56kIcQGlk2D4IHs3axWco3UfsQCcLz6NoogMee0HJAM6QVtVpYMEpIGx8pliulWWL7xXPLs1B7Pmc11Tgk7eTkYnVVLw2BGO5l0JS3wQ4mG3umx1RSVop6a/kvZO0XQlKQSHGInqLSwxcWUn9RoZHS8ar/97pkaZWVDE5/+heLIIvUC5WrupfPpOqZKc9iAjf198g4dRvsx6jYcWbqmvzQP8suGh2SU+vkfpDUAD466WN1cJf7MuB5noPcEm0bFVMuY+vGzb3mQ4kXBFzWtwR7QSKlOSPHBTLFVVFCBe3c3wL10Ei217nAcrQTiFt/DP2tCznh5H+bNWgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeea6ZuF9JagJOyK0dFRDgMm6uuldMveKjEriL5+MGY=;
 b=KPWW7bHjsMttmDzf0/cZCoW2x4Ul9hJRaZLCncacdlurnufZ1iFYjq1NvVn6+JNuo3E4HTQ85pQLoteLRQyRakUMO8EVGgSNfo98DpAibDWZhkQjqDmDkmlCQdrg8KU2H7TQCFbKZmEmQuQeqUIev8fqv8c6giAesSZqkM67tLY=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4671.namprd08.prod.outlook.com (52.135.117.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 02:36:29 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 02:36:29 +0000
Received: from localhost.localdomain (136.49.227.119) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Fri, 17 Jan 2020 02:36:20 +0000
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
Subject: [PATCH v4 7/7] iio: position: Add support for Azoteq IQS624/625 angle
 sensors
Thread-Topic: [PATCH v4 7/7] iio: position: Add support for Azoteq IQS624/625
 angle sensors
Thread-Index: AQHVzN7rwUtX3i7ooUGCcR3GEylSAQ==
Date:   Fri, 17 Jan 2020 02:36:29 +0000
Message-ID: <1579228475-6681-8-git-send-email-jeff@labundy.com>
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
x-ms-office365-filtering-correlation-id: b5abce1b-e6ac-40ab-7050-08d79af60e25
x-ms-traffictypediagnostic: SN6PR08MB4671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB4671B9CABFA5C7C0910C42C5D3310@SN6PR08MB4671.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34096005)(396003)(136003)(376002)(346002)(366004)(39830400003)(189003)(199004)(64756008)(66946007)(66556008)(66476007)(107886003)(4326008)(69590400006)(2616005)(186003)(956004)(52116002)(66446008)(6506007)(71200400001)(5660300002)(30864003)(16526019)(36756003)(6512007)(7416002)(54906003)(316002)(26005)(508600001)(81166006)(8676002)(6486002)(110136005)(86362001)(2906002)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4671;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEj2Ykas8VXRKIyl36cYkFGVhqgv2Ijkzd+9m6s+K04fsr0IM2qYoW9Vb/HhOnSECk894anHpgFjEFsad541pUBEZeK1bOm3q2yGwix743WoLrMZ22ab/B5ll8tixktTD9NKYK2xugGdB7kRBsxKMtu0TMamul36AZFukjMbZMUGhJIJzYRD4q3yW1Zd/H5XZkCV+36tlP3quxCV5a0dA8XoiYEivjMyvLBR2RVNPjuKPNdtsVzFUCf6cS0Fv68PXRWXOXZyw6HM7PQywqgwjf0ersUgWysVdLTEHTBO6BLzdyViHQE8PLmj92KoLyAJNpC0cIHHVK2XKaQcBwN0SIH8n4VHMaOK2D4PDybt/Rg8giSIOrAFqcONWYLEsUBa/QPgnn7VYcrZgEEX6+ALk+n+TcoSuWpKwtCm/TyvdugeHZKDj2eGnEtk7XhmioaxoVD2VHewTtQfp8RkMchzU70cBmkXY2FImFeXMnug8480XA5HtI0uN5xK3HVV5HBx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5abce1b-e6ac-40ab-7050-08d79af60e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:36:29.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7clLsH4r29/oJabX/zPIRKeCnGD6BMaYzmIRNNUcqMJjARXkBJ78xtIkJvGDCXrcEj2MQanIlJmMZHPWZxRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4671
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS624 and IQS625 angular position
sensors, capable of reporting the angle of a rotating shaft down to 1 and
10 degrees of accuracy, respectively.

This patch also introduces a home for linear and angular position sensors.
Unlike resolvers, they are typically contactless and use the Hall effect.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes in v4:
  - None

Changes in v3:
  - Added Reviewed-by trailer

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Added iqs624_pos_angle_en and iqs624_pos_angle_get to remove duplicate
    logic previously used throughout
  - Refactored the logic in iqs624_pos_notifier and added a lock to safely
    evaluate variables that may change in response to user action
  - Refactored the logic in iqs624_pos_read_raw
  - Added a lock to iqs624_pos_read_event_config to account for cases in wh=
ich
    the corresponding hardware state is in the process of being updated
  - Refactored the logic in iqs624_pos_write_event_config and read the init=
ial
    angle in case it changed since having first been read in iqs624_pos_ini=
t
  - Removed iqs624_pos_init as its logic has since been absorbed elsewhere
  - Removed devm_add_action_or_reset failure message
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/Kconfig               |   1 +
 drivers/iio/Makefile              |   1 +
 drivers/iio/position/Kconfig      |  19 +++
 drivers/iio/position/Makefile     |   7 +
 drivers/iio/position/iqs624-pos.c | 284 ++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 312 insertions(+)
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5bd5185..d5c073a 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -88,6 +88,7 @@ source "drivers/iio/orientation/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
+source "drivers/iio/position/Kconfig"
 source "drivers/iio/potentiometer/Kconfig"
 source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index bff682a..1712011 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -31,6 +31,7 @@ obj-y +=3D light/
 obj-y +=3D magnetometer/
 obj-y +=3D multiplexer/
 obj-y +=3D orientation/
+obj-y +=3D position/
 obj-y +=3D potentiometer/
 obj-y +=3D potentiostat/
 obj-y +=3D pressure/
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
new file mode 100644
index 0000000..eda67f0
--- /dev/null
+++ b/drivers/iio/position/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Linear and angular position sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Linear and angular position sensors"
+
+config IQS624_POS
+	tristate "Azoteq IQS624/625 angular position sensors"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Say Y here if you want to build support for the Azoteq IQS624
+	  and IQS625 angular position sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs624-pos.
+
+endmenu
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
new file mode 100644
index 0000000..3cbe7a7
--- /dev/null
+++ b/drivers/iio/position/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for IIO linear and angular position sensors
+#
+
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_IQS624_POS)	+=3D iqs624-pos.o
diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs62=
4-pos.c
new file mode 100644
index 0000000..af629bf5
--- /dev/null
+++ b/drivers/iio/position/iqs624-pos.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS624/625 Angular Position Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS624_POS_DEG_OUT			0x16
+
+#define IQS624_POS_SCALE1			(314159 / 180)
+#define IQS624_POS_SCALE2			100000
+
+struct iqs624_pos_private {
+	struct iqs62x_core *iqs62x;
+	struct notifier_block notifier;
+	struct mutex lock;
+	bool angle_en;
+	u16 angle;
+};
+
+static int iqs624_pos_angle_en(struct iqs62x_core *iqs62x, bool angle_en)
+{
+	unsigned int event_mask =3D IQS624_HALL_UI_WHL_EVENT;
+
+	/*
+	 * The IQS625 reports angular position in the form of coarse intervals,
+	 * so only interval change events are unmasked. Conversely, the IQS624
+	 * reports angular position down to one degree of resolution, so wheel
+	 * movement events are unmasked instead.
+	 */
+	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
+		event_mask =3D IQS624_HALL_UI_INT_EVENT;
+
+	return regmap_update_bits(iqs62x->map, IQS624_HALL_UI, event_mask,
+				  angle_en ? 0 : 0xFF);
+}
+
+static int iqs624_pos_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data =3D context;
+	struct iqs624_pos_private *iqs624_pos;
+	struct iqs62x_core *iqs62x;
+	struct iio_dev *indio_dev;
+	u16 angle =3D event_data->ui_data;
+	s64 timestamp;
+	int ret;
+
+	iqs624_pos =3D container_of(notifier, struct iqs624_pos_private,
+				  notifier);
+	indio_dev =3D iio_priv_to_dev(iqs624_pos);
+	timestamp =3D iio_get_time_ns(indio_dev);
+
+	iqs62x =3D iqs624_pos->iqs62x;
+	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
+		angle =3D event_data->interval;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret =3D iqs624_pos_angle_en(iqs62x, iqs624_pos->angle_en);
+		if (ret) {
+			dev_err(indio_dev->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			ret =3D NOTIFY_BAD;
+		} else {
+			ret =3D NOTIFY_OK;
+		}
+	} else if (iqs624_pos->angle_en && (angle !=3D iqs624_pos->angle)) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_NONE),
+			       timestamp);
+
+		iqs624_pos->angle =3D angle;
+		ret =3D NOTIFY_OK;
+	} else {
+		ret =3D NOTIFY_DONE;
+	}
+
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static void iqs624_pos_notifier_unregister(void *context)
+{
+	struct iqs624_pos_private *iqs624_pos =3D context;
+	struct iio_dev *indio_dev =3D iio_priv_to_dev(iqs624_pos);
+	int ret;
+
+	ret =3D blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
+						 &iqs624_pos->notifier);
+	if (ret)
+		dev_err(indio_dev->dev.parent,
+			"Failed to unregister notifier: %d\n", ret);
+}
+
+static int iqs624_pos_angle_get(struct iqs62x_core *iqs62x, unsigned int *=
val)
+{
+	int ret;
+	__le16 val_buf;
+
+	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
+		return regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
+				   val);
+
+	ret =3D regmap_raw_read(iqs62x->map, IQS624_POS_DEG_OUT, &val_buf,
+			      sizeof(val_buf));
+	if (ret)
+		return ret;
+
+	*val =3D le16_to_cpu(val_buf);
+
+	return 0;
+}
+
+static int iqs624_pos_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x =3D iqs624_pos->iqs62x;
+	unsigned int scale =3D 1;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iqs624_pos_angle_get(iqs62x, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM) {
+			ret =3D regmap_read(iqs62x->map, IQS624_INTERVAL_DIV,
+					  &scale);
+			if (ret)
+				return ret;
+		}
+
+		*val =3D scale * IQS624_POS_SCALE1;
+		*val2 =3D IQS624_POS_SCALE2;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int iqs624_pos_read_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir)
+{
+	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&iqs624_pos->lock);
+	ret =3D iqs624_pos->angle_en;
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 int state)
+{
+	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x =3D iqs624_pos->iqs62x;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	ret =3D iqs624_pos_angle_get(iqs62x, &val);
+	if (ret)
+		goto err_mutex;
+
+	ret =3D iqs624_pos_angle_en(iqs62x, state);
+	if (ret)
+		goto err_mutex;
+
+	iqs624_pos->angle =3D val;
+	iqs624_pos->angle_en =3D state;
+
+err_mutex:
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static const struct iio_info iqs624_pos_info =3D {
+	.read_raw =3D &iqs624_pos_read_raw,
+	.read_event_config =3D iqs624_pos_read_event_config,
+	.write_event_config =3D iqs624_pos_write_event_config,
+};
+
+static const struct iio_event_spec iqs624_pos_events[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_CHANGE,
+		.dir =3D IIO_EV_DIR_NONE,
+		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec iqs624_pos_channels[] =3D {
+	{
+		.type =3D IIO_ANGL,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec =3D iqs624_pos_events,
+		.num_event_specs =3D ARRAY_SIZE(iqs624_pos_events),
+	},
+};
+
+static int iqs624_pos_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+	struct iqs624_pos_private *iqs624_pos;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*iqs624_pos));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iqs624_pos =3D iio_priv(indio_dev);
+	iqs624_pos->iqs62x =3D iqs62x;
+
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->dev.parent =3D &pdev->dev;
+	indio_dev->channels =3D iqs624_pos_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(iqs624_pos_channels);
+	indio_dev->name =3D iqs62x->dev_desc->dev_name;
+	indio_dev->info =3D &iqs624_pos_info;
+
+	mutex_init(&iqs624_pos->lock);
+
+	iqs624_pos->notifier.notifier_call =3D iqs624_pos_notifier;
+	ret =3D blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
+					       &iqs624_pos->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D devm_add_action_or_reset(&pdev->dev,
+				       iqs624_pos_notifier_unregister,
+				       iqs624_pos);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs624_pos_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS624_DRV_NAME_POS,
+	},
+	.probe =3D iqs624_pos_probe,
+};
+module_platform_driver(iqs624_pos_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS624/625 Angular Position Sensors");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS624_DRV_NAME_POS);
--
2.7.4

