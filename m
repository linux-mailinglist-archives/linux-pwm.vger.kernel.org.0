Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7C12E0EA
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jan 2020 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgAAWvN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Jan 2020 17:51:13 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:6250
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbgAAWvN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Jan 2020 17:51:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1wsF7Huw4zvJ1/6n6da2YFT4j7FZEhuXPrmktCkA4PFVJeyl5CEe8eTxFq/iPVgGKW0ci7aCcdYGcNaoj3JGZYwB8JMhq4jr1FvQT8hkDSYnvtVcfDJDh+2XcegrDilgBBoU16DJqqLuRrmR7fgueVmIj6D+7Cl4XJZ9+uIqKIePvLw7ZnWqaFlrHTkP9kJdk0cuOKSv55uuICPwVOu24HTJ1aNvepSzPQBmMSk2elJAurdw4DP7H9CAmxYQI2hWjelaqc5xaoOFGiWpO963HouJuBTHy2Gfoe0skvkzxpRPxo9WE+4xKjsrEnBkIdBoXveCXLagk7EqY8D+35JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK0NcIKdQBOHHb/bq8IpYXKFzDFMGMVbKunC4h0KuqQ=;
 b=OBmVOO4yL3FOeTcokZVA3Oj3Jw5a7Ed0701bsTQt3dqmQLpCwh2pvks3HcX63cSkhD9E8w5q5MWyvpYFf9P853SnmyOYL2zaZ1UVtT+ukQTR38v831xQu3RYKyscP+34kTdlrEftOg9lNEj1XhukXFPU1VGfS73+L0EXf5ytF6/R3MWVGbU+UnqfnJ8xPzwjFr9z/7TxhjwQKgdDTGHiGWCD7Eu8bgn/ruu9PC0/FfVmsIYnoc5/o+HjmrGSKb7dHSnYj4MqeFdXTDXHJFkOehfvLft03GnTLh/D7sVFWXPAFJ/SONzIXGb2iO8OES4Y8cay2SLV5v9GyXhcls4lpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK0NcIKdQBOHHb/bq8IpYXKFzDFMGMVbKunC4h0KuqQ=;
 b=p7DkAdxTrFY29v46IvxI1PvZy9WiWT055+bb2WqttG6ALXVLxEtSa6hsZfsrLAMTK7E7uavjA9h6olnG7YtpmOid+UB5cjs8debjTde2ZY/gRoADL20zTp31xtS9lQmOOVjUEwe0IFKPz4EIEfGSpq6FBsHRogbZ7X5jl/yum2Y=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5357.namprd08.prod.outlook.com (52.135.114.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 1 Jan 2020 22:51:08 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2581.007; Wed, 1 Jan 2020
 22:51:08 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0501CA0154.namprd05.prod.outlook.com (2603:10b6:803:2c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.9 via Frontend Transport; Wed, 1 Jan 2020 22:51:06 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 7/7] iio: position: Add support for Azoteq IQS624/625
 angle sensors
Thread-Topic: [PATCH v2 7/7] iio: position: Add support for Azoteq IQS624/625
 angle sensors
Thread-Index: AQHVrikBIkVSIrZAc0Gxy9PYoURzHae7dAYAgBsbhQA=
Date:   Wed, 1 Jan 2020 22:51:08 +0000
Message-ID: <20200101225058.GC14339@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-8-git-send-email-jeff@labundy.com>
 <20191215165328.789e8a16@archlinux>
In-Reply-To: <20191215165328.789e8a16@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0154.namprd05.prod.outlook.com
 (2603:10b6:803:2c::32) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec84bcdc-1cac-400d-19f6-08d78f0d16ff
x-ms-traffictypediagnostic: SN6PR08MB5357:
x-microsoft-antispam-prvs: <SN6PR08MB53571CE78E3622581B270A78D3210@SN6PR08MB5357.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02698DF457
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39830400003)(396003)(346002)(376002)(34096005)(189003)(501634003)(199004)(66446008)(64756008)(26005)(66556008)(66476007)(54906003)(956004)(1076003)(2616005)(52116002)(36756003)(316002)(16526019)(86362001)(2906002)(30864003)(186003)(66946007)(508600001)(33656002)(81156014)(81166006)(71200400001)(7416002)(6916009)(5660300002)(8936002)(7696005)(55016002)(8886007)(8676002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5357;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7Ygqca7eLG80X2tN6HYGs9aUAv5cykWALN87t5+31i7yuDBibriRon0SZMLCMPEC6MTkcz4JoTB9ODjHfIegNsFMic8E9nNgZUXATDMkBGHcQn49wMQ3oM+svArAmbR4vq5KQelwe9RREEjxPPlz5pzgYMgint22TO/PIPryzZJo8g3kRXGzxSbMhC/DA1rXmEO4ahpK24OcbOhxhDQ7XUMmukOFg8lfxbQIVJfPeMviNhGeyxB1prPh3GQ/F5zCMNM1JMmsf5wzKHxEM/9xR7te+JNU7GHBK+PPT/GtlDbxcQ0NRpjpb0ad6yQvu80JsXar5ARVGCBj/Dp1IJlSyoQNU1rHVZzeqz6LkI69n13rhwY3JP8qluzRd7JyB094QiwyfeNgfqDwzbu1JRHmbWWTw0Fz0T2HUUStbuD0Txt/x+M2T1vaUELpqAlnRA118maLO7OoJM1o1pwqYtRalyhdLYpUVqP+p8nPo9YEvNwkpAyM4V7KTwyKIdLOuLA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E418FDC8470AC54BACA1F542823AE577@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec84bcdc-1cac-400d-19f6-08d78f0d16ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2020 22:51:08.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMgvHzyLszpORFVFoNLwszU38nc5p9Vop/1zAwMHXIwiLZapASKeeDw18WZMNgYCD3aM/wU6e0pZONoeOSUSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5357
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jonathan,

Thank you for your continued support on this project.

On Sun, Dec 15, 2019 at 04:53:28PM +0000, Jonathan Cameron wrote:
> On Mon, 9 Dec 2019 00:38:41 +0000
> Jeff LaBundy <jeff@labundy.com> wrote:
>=20
> > This patch adds support for the Azoteq IQS624 and IQS625 angular positi=
on
> > sensors, capable of reporting the angle of a rotating shaft down to 1 a=
nd
> > 10 degrees of accuracy, respectively.
> >=20
> > This patch also introduces a home for linear and angular position senso=
rs.
> > Unlike resolvers, they are typically contactless and use the Hall effec=
t.
> >=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
>=20
> Looks good
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> My current assumption is that Lee will take this lot via an immutable bra=
nch
> in MFD once it's ready.  Shout if a different path makes sense.

Same here. @Lee, please let us know if you disagree.

> > ---
> > Changes in v2:
> >   - Merged 'Copyright' and 'Author' lines into one in introductory comm=
ents
> >   - Replaced 'error' with 'ret' throughout
> >   - Added iqs624_pos_angle_en and iqs624_pos_angle_get to remove duplic=
ate
> >     logic previously used throughout
> >   - Refactored the logic in iqs624_pos_notifier and added a lock to saf=
ely
> >     evaluate variables that may change in response to user action
> >   - Refactored the logic in iqs624_pos_read_raw
> >   - Added a lock to iqs624_pos_read_event_config to account for cases i=
n which
> >     the corresponding hardware state is in the process of being updated
> >   - Refactored the logic in iqs624_pos_write_event_config and read the =
initial
> >     angle in case it changed since having first been read in iqs624_pos=
_init
> >   - Removed iqs624_pos_init as its logic has since been absorbed elsewh=
ere
> >   - Removed devm_add_action_or_reset failure message
> >   - Eliminated tabbed alignment of platform_driver struct members
> >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> >=20
> >  drivers/iio/Kconfig               |   1 +
> >  drivers/iio/Makefile              |   1 +
> >  drivers/iio/position/Kconfig      |  19 +++
> >  drivers/iio/position/Makefile     |   7 +
> >  drivers/iio/position/iqs624-pos.c | 284 ++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 312 insertions(+)
> >  create mode 100644 drivers/iio/position/Kconfig
> >  create mode 100644 drivers/iio/position/Makefile
> >  create mode 100644 drivers/iio/position/iqs624-pos.c
> >=20
> > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > index 5bd5185..d5c073a 100644
> > --- a/drivers/iio/Kconfig
> > +++ b/drivers/iio/Kconfig
> > @@ -88,6 +88,7 @@ source "drivers/iio/orientation/Kconfig"
> >  if IIO_TRIGGER
> >     source "drivers/iio/trigger/Kconfig"
> >  endif #IIO_TRIGGER
> > +source "drivers/iio/position/Kconfig"
> >  source "drivers/iio/potentiometer/Kconfig"
> >  source "drivers/iio/potentiostat/Kconfig"
> >  source "drivers/iio/pressure/Kconfig"
> > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > index bff682a..1712011 100644
> > --- a/drivers/iio/Makefile
> > +++ b/drivers/iio/Makefile
> > @@ -31,6 +31,7 @@ obj-y +=3D light/
> >  obj-y +=3D magnetometer/
> >  obj-y +=3D multiplexer/
> >  obj-y +=3D orientation/
> > +obj-y +=3D position/
> >  obj-y +=3D potentiometer/
> >  obj-y +=3D potentiostat/
> >  obj-y +=3D pressure/
> > diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfi=
g
> > new file mode 100644
> > index 0000000..eda67f0
> > --- /dev/null
> > +++ b/drivers/iio/position/Kconfig
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Linear and angular position sensors
> > +#
> > +# When adding new entries keep the list in alphabetical order
> > +
> > +menu "Linear and angular position sensors"
> > +
> > +config IQS624_POS
> > +	tristate "Azoteq IQS624/625 angular position sensors"
> > +	depends on MFD_IQS62X || COMPILE_TEST
> > +	help
> > +	  Say Y here if you want to build support for the Azoteq IQS624
> > +	  and IQS625 angular position sensors.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called iqs624-pos.
> > +
> > +endmenu
> > diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makef=
ile
> > new file mode 100644
> > index 0000000..3cbe7a7
> > --- /dev/null
> > +++ b/drivers/iio/position/Makefile
> > @@ -0,0 +1,7 @@
> > +#
> > +# Makefile for IIO linear and angular position sensors
> > +#
> > +
> > +# When adding new entries keep the list in alphabetical order
> > +
> > +obj-$(CONFIG_IQS624_POS)	+=3D iqs624-pos.o
> > diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/i=
qs624-pos.c
> > new file mode 100644
> > index 0000000..af629bf5
> > --- /dev/null
> > +++ b/drivers/iio/position/iqs624-pos.c
> > @@ -0,0 +1,284 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS624/625 Angular Position Sensors
> > + *
> > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define IQS624_POS_DEG_OUT			0x16
> > +
> > +#define IQS624_POS_SCALE1			(314159 / 180)
> > +#define IQS624_POS_SCALE2			100000
> > +
> > +struct iqs624_pos_private {
> > +	struct iqs62x_core *iqs62x;
> > +	struct notifier_block notifier;
> > +	struct mutex lock;
> > +	bool angle_en;
> > +	u16 angle;
> > +};
> > +
> > +static int iqs624_pos_angle_en(struct iqs62x_core *iqs62x, bool angle_=
en)
> > +{
> > +	unsigned int event_mask =3D IQS624_HALL_UI_WHL_EVENT;
> > +
> > +	/*
> > +	 * The IQS625 reports angular position in the form of coarse interval=
s,
> > +	 * so only interval change events are unmasked. Conversely, the IQS62=
4
> > +	 * reports angular position down to one degree of resolution, so whee=
l
> > +	 * movement events are unmasked instead.
> > +	 */
> > +	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
> > +		event_mask =3D IQS624_HALL_UI_INT_EVENT;
> > +
> > +	return regmap_update_bits(iqs62x->map, IQS624_HALL_UI, event_mask,
> > +				  angle_en ? 0 : 0xFF);
> > +}
> > +
> > +static int iqs624_pos_notifier(struct notifier_block *notifier,
> > +			       unsigned long event_flags, void *context)
> > +{
> > +	struct iqs62x_event_data *event_data =3D context;
> > +	struct iqs624_pos_private *iqs624_pos;
> > +	struct iqs62x_core *iqs62x;
> > +	struct iio_dev *indio_dev;
> > +	u16 angle =3D event_data->ui_data;
> > +	s64 timestamp;
> > +	int ret;
> > +
> > +	iqs624_pos =3D container_of(notifier, struct iqs624_pos_private,
> > +				  notifier);
> > +	indio_dev =3D iio_priv_to_dev(iqs624_pos);
> > +	timestamp =3D iio_get_time_ns(indio_dev);
> > +
> > +	iqs62x =3D iqs624_pos->iqs62x;
> > +	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
> > +		angle =3D event_data->interval;
> > +
> > +	mutex_lock(&iqs624_pos->lock);
> > +
> > +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> > +		ret =3D iqs624_pos_angle_en(iqs62x, iqs624_pos->angle_en);
> > +		if (ret) {
> > +			dev_err(indio_dev->dev.parent,
> > +				"Failed to re-initialize device: %d\n", ret);
> > +			ret =3D NOTIFY_BAD;
> > +		} else {
> > +			ret =3D NOTIFY_OK;
> > +		}
> > +	} else if (iqs624_pos->angle_en && (angle !=3D iqs624_pos->angle)) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 0,
> > +						    IIO_EV_TYPE_CHANGE,
> > +						    IIO_EV_DIR_NONE),
> > +			       timestamp);
> > +
> > +		iqs624_pos->angle =3D angle;
> > +		ret =3D NOTIFY_OK;
> > +	} else {
> > +		ret =3D NOTIFY_DONE;
> > +	}
> > +
> > +	mutex_unlock(&iqs624_pos->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void iqs624_pos_notifier_unregister(void *context)
> > +{
> > +	struct iqs624_pos_private *iqs624_pos =3D context;
> > +	struct iio_dev *indio_dev =3D iio_priv_to_dev(iqs624_pos);
> > +	int ret;
> > +
> > +	ret =3D blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
> > +						 &iqs624_pos->notifier);
> > +	if (ret)
> > +		dev_err(indio_dev->dev.parent,
> > +			"Failed to unregister notifier: %d\n", ret);
> > +}
> > +
> > +static int iqs624_pos_angle_get(struct iqs62x_core *iqs62x, unsigned i=
nt *val)
> > +{
> > +	int ret;
> > +	__le16 val_buf;
> > +
> > +	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
> > +		return regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
> > +				   val);
> > +
> > +	ret =3D regmap_raw_read(iqs62x->map, IQS624_POS_DEG_OUT, &val_buf,
> > +			      sizeof(val_buf));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val =3D le16_to_cpu(val_buf);
> > +
> > +	return 0;
> > +}
> > +
> > +static int iqs624_pos_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long mask)
> > +{
> > +	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
> > +	struct iqs62x_core *iqs62x =3D iqs624_pos->iqs62x;
> > +	unsigned int scale =3D 1;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D iqs624_pos_angle_get(iqs62x, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM) {
> > +			ret =3D regmap_read(iqs62x->map, IQS624_INTERVAL_DIV,
> > +					  &scale);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		*val =3D scale * IQS624_POS_SCALE1;
> > +		*val2 =3D IQS624_POS_SCALE2;
> > +		return IIO_VAL_FRACTIONAL;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int iqs624_pos_read_event_config(struct iio_dev *indio_dev,
> > +					const struct iio_chan_spec *chan,
> > +					enum iio_event_type type,
> > +					enum iio_event_direction dir)
> > +{
> > +	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&iqs624_pos->lock);
> > +	ret =3D iqs624_pos->angle_en;
> > +	mutex_unlock(&iqs624_pos->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
> > +					 const struct iio_chan_spec *chan,
> > +					 enum iio_event_type type,
> > +					 enum iio_event_direction dir,
> > +					 int state)
> > +{
> > +	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
> > +	struct iqs62x_core *iqs62x =3D iqs624_pos->iqs62x;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	mutex_lock(&iqs624_pos->lock);
> > +
> > +	ret =3D iqs624_pos_angle_get(iqs62x, &val);
> > +	if (ret)
> > +		goto err_mutex;
> > +
> > +	ret =3D iqs624_pos_angle_en(iqs62x, state);
> > +	if (ret)
> > +		goto err_mutex;
> > +
> > +	iqs624_pos->angle =3D val;
> > +	iqs624_pos->angle_en =3D state;
> > +
> > +err_mutex:
> > +	mutex_unlock(&iqs624_pos->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info iqs624_pos_info =3D {
> > +	.read_raw =3D &iqs624_pos_read_raw,
> > +	.read_event_config =3D iqs624_pos_read_event_config,
> > +	.write_event_config =3D iqs624_pos_write_event_config,
> > +};
> > +
> > +static const struct iio_event_spec iqs624_pos_events[] =3D {
> > +	{
> > +		.type =3D IIO_EV_TYPE_CHANGE,
> > +		.dir =3D IIO_EV_DIR_NONE,
> > +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec iqs624_pos_channels[] =3D {
> > +	{
> > +		.type =3D IIO_ANGL,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.event_spec =3D iqs624_pos_events,
> > +		.num_event_specs =3D ARRAY_SIZE(iqs624_pos_events),
> > +	},
> > +};
> > +
> > +static int iqs624_pos_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct iqs624_pos_private *iqs624_pos;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*iqs624_pos));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	iqs624_pos =3D iio_priv(indio_dev);
> > +	iqs624_pos->iqs62x =3D iqs62x;
> > +
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->dev.parent =3D &pdev->dev;
> > +	indio_dev->channels =3D iqs624_pos_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(iqs624_pos_channels);
> > +	indio_dev->name =3D iqs62x->dev_desc->dev_name;
> > +	indio_dev->info =3D &iqs624_pos_info;
> > +
> > +	mutex_init(&iqs624_pos->lock);
> > +
> > +	iqs624_pos->notifier.notifier_call =3D iqs624_pos_notifier;
> > +	ret =3D blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
> > +					       &iqs624_pos->notifier);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       iqs624_pos_notifier_unregister,
> > +				       iqs624_pos);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&pdev->dev, indio_dev);
> > +}
> > +
> > +static struct platform_driver iqs624_pos_platform_driver =3D {
> > +	.driver =3D {
> > +		.name =3D IQS624_DRV_NAME_POS,
> > +	},
> > +	.probe =3D iqs624_pos_probe,
> > +};
> > +module_platform_driver(iqs624_pos_platform_driver);
> > +
> > +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> > +MODULE_DESCRIPTION("Azoteq IQS624/625 Angular Position Sensors");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" IQS624_DRV_NAME_POS);
> > --
> > 2.7.4
> >=20
>=20

Wishing you a Happy New Year,
Jeff LaBundy
