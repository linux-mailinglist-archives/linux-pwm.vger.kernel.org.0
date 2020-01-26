Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60A149C93
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jan 2020 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAZTnS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jan 2020 14:43:18 -0500
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:14571
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728266AbgAZTnS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jan 2020 14:43:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyXU3b2lBwOhoNf1Ac3r5LDPzZLBg5awfcliR4bDVZ58Gdji/+PsTumc3OF5+JEU6g8y8IQSqYwQtfAD5xk78sq776g8TIr+S5goci7xvTHFJJJhrBBwXRwKV6Iz3RJjCLJjz8kz014fsNWBbHUK8fbB3ROYjao3KHkEP9pRr6Vbx71AjhcOHvdqrGrqNGzf1bor0jlGuGtSYEUWG+18N9Lnln/ZlKNdTGCnfQVetUS+ElM2fGCyVb3UyrLTJrlies5ACOg5M+Uf2vxl4+KqWCgAjjVLZXu52J1ztOeagXgpdjmpDhVbRBpTf/sO+l19vxLqI7Vi+gcpzSkM16wE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuU3/3TOYqXpknpdcB2DIPKk3TTnv1n4Wb1c6QNJHYQ=;
 b=cp4Vblmv9C22g7PCPwvXFzv12fkdXeS6BBcIAOiQoS4ROTP0a907k2bfLUiIFDTNN209xG/zno1BxWs6+D8RDam2TgpPzqFMr48VO2JXR6DaC/0JKEQCHN+WJlti2LkAhbIKg9e6FAAYGK6wF7GfFiMnRgW48AN+6ewNlQoOU5nHjU0EgAY9CY/NK1AFB9F+9kmbeIli8YMMsOVBOZo9yxaiujyRn7py9EAeXRSYAAJR+8Uji/L/dIiLjdfZHxlPQwyfFcoiqHY/OTVRsJXZbeL/Q3915IlGnvNJf9HzLaPeORLuFlDnKRReVVRqU6ef6uLRBOkD1TRjVvFTFRp/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuU3/3TOYqXpknpdcB2DIPKk3TTnv1n4Wb1c6QNJHYQ=;
 b=Wiv22rPWXnMIj/yhLrpkY53k0Zd1HrMM2arML1/q8em7c/3ZZfqTWZ8kj7D34hKxVhR/u0bicEJxzATvjMKrbQzLOgPEfgggh111dcCrBN05frZ+DGaaBwIaUlFwIciVOU/DhgLbVZ7073A0MdnKtNvUWBr0yoUeG9VC9czTg6Y=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4606.namprd08.prod.outlook.com (52.135.115.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 19:42:39 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 19:42:39 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0201CA0012.namprd02.prod.outlook.com (2603:10b6:803:2b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Sun, 26 Jan 2020 19:42:39 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 3/3] leds: pwm: don't set the brightness during .probe
Thread-Topic: [PATCH 3/3] leds: pwm: don't set the brightness during .probe
Thread-Index: AQHV0tbsjSDSZ59WzEeqLGygW3WW/qf9W9YA
Date:   Sun, 26 Jan 2020 19:42:39 +0000
Message-ID: <20200126194236.GC2569@labundy.com>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-4-uwe@kleine-koenig.org>
In-Reply-To: <20200124165409.12422-4-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:803:2b::22) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a42cffe-082f-4676-f013-08d7a297e6e4
x-ms-traffictypediagnostic: SN6PR08MB4606:
x-microsoft-antispam-prvs: <SN6PR08MB4606A9FF51F9E8BF80DF6B62D3080@SN6PR08MB4606.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39830400003)(376002)(199004)(189003)(6916009)(36756003)(33656002)(5660300002)(508600001)(54906003)(86362001)(956004)(8676002)(81156014)(81166006)(8936002)(316002)(2616005)(8886007)(4326008)(2906002)(55016002)(7696005)(71200400001)(66574012)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(16526019)(186003)(1076003)(52116002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4606;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gE/H1hsw5byuVd42cv/zuTmYXkS2v/64ZXSwBMrFFHWs8kXyR9yzimQwzsQMjach3NF67ETT25KflAoZp9Vf/w6y3lsyaesbIThGkM4U+575ku1zYY70Angd0+5vmcXX1aWPdSYUQK19llQx/eUVe5i60k0Mmrdf4Bo5KESgCL8FbkVeQttVMWu4/UUGW7EoNYczabtOX63clN4pCZFSJy5UrR1YQp3Xc5xvJZazDB1rbOERzRTH7X0IA9seiaZcKyglPQhE4QnAPN+C9M5LdDQW7OaxA3DfyCD7S4Ns+NBbQInKtwa1XUPv1Udnf4+DGwUTxwzmYzG5i7Tvlzo27ZnV73zO4Y3AL0tVtWphwEZs6WDQLzwFIlaMritA+fJDZUWA7YgbLIV9M72ggRwAkCPIdsndsIDW9JF0Yg3uHHyXXjKkFs7NAZevP+rir/3B8MT0vcY20kQxFHp90F1PN+kwUCRS8k6tcTMWH3rDjq6ADhjD9NFpOY/sOIrRaBTP
x-ms-exchange-antispam-messagedata: SAAze+uwVYWCjE4T/cGCCq3wxFDGXtKlt3F0f0EuxTHux/yJ6pUWFGg4pV1c26FyGNGX9s/aY9G5c2LUB6i5pBBadvDoy6eL6dIerQKiXbaJrncibZFtg7P/pvzw3IedEdCZ2xgMlf151cNRUa29Rg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5CBE401259C81749A5F29E46CB1DD7AE@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a42cffe-082f-4676-f013-08d7a297e6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 19:42:39.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjxMnVpKaWAQ29S+oS3qdFXRwA2B3qvkWKIhun9ZD3PSOT9+pPsIts+iaasbl1YPhxBybVe70FbYnEqelq6LYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4606
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your work on this series.

On Fri, Jan 24, 2020 at 05:54:09PM +0100, Uwe Kleine-K=F6nig wrote:
> The explicit call to led_pwm_set() prevents that the led's state can
> stay as configured by the bootloader.
>=20
> Note that brightness is always 0 here as the led_pwm driver doesn't
> provide a .brightness_get() callback and so the LED was disabled
> unconditionally.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/leds/leds-pwm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 9111cdede0ee..de74e1c8d234 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -83,13 +83,11 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
>  		led_data->pwmstate.period =3D led->pwm_period_ns;
> =20
>  	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
> -	if (ret =3D=3D 0) {
> +	if (ret =3D=3D 0)
>  		priv->num_leds++;
> -		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
> -	} else {
> +	else
>  		dev_err(dev, "failed to register PWM led for %s: %d\n",
>  			led->name, ret);
> -	}
> =20
>  	return ret;
>  }
> --=20
> 2.24.0
>=20

My only concern here is whether or not there happen to be some hardware
out in the world whose PWM-related registers power on to a random state
and unknowingly depended on brightness being forced to zero.

The other folks on the thread probably have some better view into this,
but I wonder if the safest option would be to adopt the "default-state"
property from leds/common.txt, and only forgo the call to led_pwm_set()
if the property is set to "keep".

I did test this and can confirm that the LED's state prior to the driver
being loaded is preserved. However as you've warned, the brightness read
back from user space is zero and does not match the actual brightness of
the LED.

Understanding that it's more work, I wonder if this patch is not safe if
we don't also add a brightness_get callback in case there were any cases
where user space makes some decisions based on brightness =3D=3D 0?

At any rate this patch does what is advertised, and so:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
