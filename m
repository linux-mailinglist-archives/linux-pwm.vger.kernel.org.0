Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DA15CF80
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2020 02:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBNBgA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Feb 2020 20:36:00 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:44355 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbgBNBgA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Feb 2020 20:36:00 -0500
Received: from [100.113.0.217] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 96/A7-54715-A79F54E5; Fri, 14 Feb 2020 01:35:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjH+/aud5VQdrYiLw1MUpmLjJayxe0
  kmiCMcZtuEWO2umXgIZV2aw9sSwRcHEiAKSISrAO0gPzaxmCN/NjQoWT8nFBkk4lFZBiEgSBg
  RNgIAva86rZ/Lt/3+Xzveb7vm/cVIuISXCpUJ5rUBobWyTAXVBMgZuTJi2GRyqmGjeRjSxdKt
  pZOADKtzIqRw/PtgBx4tCAg+y6fx8ihoSpAzj9ZwsnMi+cEZM65KQE5YxvDydWmRpzszhKQdb
  VmhFy8XISSg7l5IJigZu3pOHWpcAinaquOY9Sd/iaMmrl+HaeKrkVQzZZqnKqwS6icZSU19s8
  VhJqrfZmyZUyju10/FmiZ6LjE/QLNhdt5WPy0JLHhxywsBYy8dAK4CAFRgcDZpQFwAqxxLDpQ
  2NKp5EAdgEvZixgLUOJXBLaNbGOBmMjhw96Vm3xuMQzg0OQCwrowwh+OFFj5rF5HHIJTd3pR1
  oQQHQLYmzooYIGECIG92TacM4XCmoJi5w9BsH78Lp8b9wocuPLoWSYR8Sk8VfQb4KY1ANje9h
  hlwRpiO5x9UOXIJ3SE9YY3+73YMkJ4wNujXE9IELC8qRfhtDu8f29FwO0zCqZMnnfW/WHPrVH
  AaRks76vDOe0NbxRnOevvw47WJaffD3ZmLjo1Ccuz0lE2AiR84UpLElfWwZmT5c4Im+BsboOA
  s3jB6Ypd7E4g0YDC1oU/sdNAWfif1JxWQLv5DMbp12DlhSmk8NlJrIXXCkbREoBWga3RBm2sx
  qSntTp5oFIpDwx8Q+74vv6mgk6W0wp1gvyAmjEZaAdV0IeNCmOS/oAuRsGoTbXAcVljDvGONo
  In1bOKFuAp5MvcRacqwyLFbtFxMUka2qiJMiTo1MYW4CUUyqDo1t8OttagjlUnHtTqHFf+OYZ
  CV9k6kS+LRcZ4Wm/UxnKoC8iFp+9bShExysQxaqmHaII1EaxJk8C8aPH84dwA3lKJCPB4PLFr
  vNqg15r+zyeBhxDIJCKS7eKqZUwvJk06QvAdIbI3v82GMNH/ImkK/8Pgj1TwoIr6xm94Kfnwu
  6+KesbjpNWlP20vN4e+g981e83V7HPf8ll+akuAlYw4ot+RfXHkL1Nd2bdzZJklcK9yuSTtoQ
  3J69821ucWGzCe3lezaE9S8dqu7jqWPrTpUn39WS+7pPjn4FC3XLfjmUF7KnzQ3B92Nj7M1w7
  +/slX/ql+ezIy8iuTLfax1fVB1ROQx4Rbw5t3nB0J+9zTunU17Z6n6gP/L13GKXfvKPBFSP73
  7701zIRqtfaQ4HkXX4tmChyhN7hu3tJ9Um/e0D2/tzl7VGVdv18l3fnA9sdqzcaI75Lafb72M
  XbEHO0KH1/dvbzP2zOy8ZdIa/zVoJ5OGy1DjRo60A8xGOmndj7PWLMEAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-3.tower-233.messagelabs.com!1581644154!1657133!1
X-Originating-IP: [104.47.18.110]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20339 invoked from network); 14 Feb 2020 01:35:54 -0000
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO EUR05-AM6-obe.outbound.protection.outlook.com) (104.47.18.110)
  by server-3.tower-233.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Feb 2020 01:35:54 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbtw78uvv63QxSRRgjPnI+RYYbkaHq9YARAyxIHKp27m6EZ9WxprI8eopRsbD1kSpDRU8bYJvIF2n0cQbJ/F/HD4lQeZpJ5pv/mCL94AQ+Bhe3y6k/rQxxxWDsQfTER473162a8WUUehnvhxhrmf1BJSoYVeylESNAD2EKQNdYyAxGp4RpL+TfYK8wv9AhsnlGEPu/q0W2IqBzJRRcwnWvU07rFcs3cLSVLGGpD7sGcxYD+JDrD9qYBNRAW0+9tyIq3ol1aRMqk0aPxVe4pkfE1fybHSou08bq6YKuE9vdkk+aRAedsEovK7GfjQKwVl2dqVAkiF4npT/+Oq41UbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BQCMaIcXnYnTnBy26YCbZdPKWqf+hFQ/LaKjbOoAvY=;
 b=NwQQ9ZH2bJRo1wHkqZYvhFCET7gTjiAWjHqs4UkVXpSj1ySAsMm33YHHKTPGUyxqcEaRK97KgZhXSaBqc3UQUTfsJts0pXwVnkXwwNNxgWgvXWchcku/vGE7iytxsNDx/dvpxUc6EThZNEEAFeLLgOFRRjp03ZGseSW66+cr92ncQyRj8B/qyupyw2XpljNgP7ra5Z80AKonjr3fJ2kbs4GDTEfYjoyDQYATW+NOy+kWZpxwvICnAt6GweBdYbNUDY1BcTuophjpDgFzZ3q8aSi3Q28ioSvYgwAlC3xbJSJ8A75t52OVh1db1eQmakZhzJl9qfRU99CO0pSzLMqo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BQCMaIcXnYnTnBy26YCbZdPKWqf+hFQ/LaKjbOoAvY=;
 b=cVqNGmdfJ2tylFkJufMFSQJi55L/UW1uNvg9BqwR+TGQKqYddshJFYLfo+qZlENmeYOU6mL209KgnrrxR9X20LiX3WvV6YGZPqIN0J8oHEl/uvfl+ZR2ro+UNe4uzZjP4hd+DpZIjN0PbgrqjWW9hvb689ZgvprFyg/a6F8UBsI=
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM (20.179.30.210) by
 VE1PR10MB3022.EURPRD10.PROD.OUTLOOK.COM (20.179.30.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 14 Feb 2020 01:35:51 +0000
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d9e:307f:1367:a15d]) by VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d9e:307f:1367:a15d%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 01:35:51 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Roy Im <roy.im.opensource@diasemi.com>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [RESEND PATCH V8 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V8 3/3] Input: new da7280 haptic driver
Thread-Index: AQHV4IUIGUlnvIDwGkyxgGOIY5mzdagWDW0AgAPcK6A=
Date:   Fri, 14 Feb 2020 01:35:50 +0000
Message-ID: <VE1PR10MB3085C12BDD9B0713A5A1772785150@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1581383604.git.Roy.Im@diasemi.com>
 <ba04fc95afbf3d77a49ad6d52ade20fe79a4b7eb.1581383604.git.Roy.Im@diasemi.com>
 <20200211142622.5vt34ftdt242agaq@pengutronix.de>
In-Reply-To: <20200211142622.5vt34ftdt242agaq@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.116.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b2d278-a30c-4776-5b78-08d7b0ee39b3
x-ms-traffictypediagnostic: VE1PR10MB3022:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB3022DDDBC71F1030EB77AE64A2150@VE1PR10MB3022.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39840400004)(136003)(376002)(366004)(189003)(199004)(66946007)(66476007)(26005)(8936002)(86362001)(66556008)(66574012)(55016002)(966005)(4326008)(64756008)(7696005)(81156014)(6506007)(81166006)(7416002)(33656002)(9686003)(66446008)(8676002)(76116006)(55236004)(478600001)(110136005)(71200400001)(316002)(54906003)(186003)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3022;H:VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVT8xUspEgI+Qk9MQDvT9pVlOwefdzhw3AxclTNO0zrMD+Q3ootSzYy11a3uGRItGnqXilS3szdU0Hzwk/NV7ML0UUfwm1ZoeAcN6C/86UnAcH25F1k7FcRPl/MVsM+Rlv/qKyvx04x/9kchh8rUZoEHM/1uv3ub0NLF1143Gh3uEsVq5cj5I0RzmFtgvrQ1NkDL7b5tphxPZ+KBn2LOiTqtFqI1PnNmTzmUyr2k9yrvlqgQhjT7M88CKGdoohshlpGBX/Fpsrm9OR3tAOKgpxclXecHTEqaik1vVrDbJeBbAEJaLvO7F0G27yPD7WegQExVG9z9bAYjl9cae8qDjLeanJY/3IIP4Snxc8oB59IZIbEqZCGCTZLCf1RWibRSn/dbO6XxhOvt4ERWKoF7GLKH0vMqWuq1/6Rb3ZyBgx57psw1MBbcjtBEarRcug76VEulhLORVRRZ5QPY2v1EGjwCCtBIobfSOmBBvYpJRqFuOqDwJSTgYjv24/YuzYnk0ClsCUn5XD5VR0JWmWuDxg==
x-ms-exchange-antispam-messagedata: K2I5qFw4ae5osmDbCIlKeykkp4y13RGoXZrO4a+pY9aNcimJ1mUKh//YgqkAAkqofuLbFb6kfqzZIYMwGENecEeFw2JUoq4v2v7fzjI1Icd58hMu07E+auSKjVEkdG2wRs6+YLOeoz7oirUgiiZAng==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2d278-a30c-4776-5b78-08d7b0ee39b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 01:35:51.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fH/owldyR50IFS0DtGX3jYxdFtOVhXaMlc8Thjn1O9n3uTJekuBjvhIuKWoyrrzNDnRtYzD7dc57O6GHfLH34g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3022
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tuesday, February 11, 2020 11:26 PM, Uwe Kleine-K=F6nig wrote

> On Tue, Feb 11, 2020 at 10:13:24AM +0900, Roy Im wrote:
> > diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> > new file mode 100644 index 0000000..4d1d1fc
> > --- /dev/null
> > +++ b/drivers/input/misc/da7280.c
> > @@ -0,0 +1,1688 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * DA7280 Haptic device driver
> > + *
> > + * Copyright (c) 2019 Dialog Semiconductor.
> > + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>  */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/uaccess.h>
> > +#include "da7280.h"
>=20
> Don't introduce a header file that is only used once. Better put the defi=
nitions into the c file then.

I will put the definitions into the c file.

>=20
> > [...]
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics) {
> > +	struct pwm_args pargs;
> > +	u64 period_mag_multi;
> > +	unsigned int pwm_duty;
> > +	int error;
> > +
> > +	pwm_get_args(haptics->pwm_dev, &pargs);
> > +	period_mag_multi =3D
> > +		(u64)(pargs.period * haptics->gain);
>=20
> This cast does not do anything, does it?

I will remove this.

>=20
> > +	if (haptics->acc_en)
> > +		pwm_duty =3D
> > +			(unsigned int)(period_mag_multi >> 16);
> > +	else
> > +		pwm_duty =3D
> > +			(unsigned int)((period_mag_multi >> 16)
> > +				+ pargs.period) / 2;
> > +
> > +	error =3D pwm_config(haptics->pwm_dev,
> > +			   pwm_duty, pargs.period);
> > +	if (error) {
> > +		dev_err(haptics->dev,
> > +			"failed to configure pwm : %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	error =3D pwm_enable(haptics->pwm_dev);
> > +	if (error) {
> > +		pwm_disable(haptics->pwm_dev);
> > +		dev_err(haptics->dev,
> > +			"failed to enable haptics pwm device : %d\n", error);
> > +	}
>=20
> You should not use the legacy pwm API. Please stick to pwm_apply_state().
>=20
> Also consider using %pE for more expressive error messages.

I will replace the legacy pwm API and stick to pwm_apply_state() and consid=
er using the %pE.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Hello Uwe,

Thanks for your comments.
I will try to update as you advise.

Best regards,
Roy
