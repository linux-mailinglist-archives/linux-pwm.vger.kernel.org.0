Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FF149C5E
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jan 2020 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgAZSzQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jan 2020 13:55:16 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:30592
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgAZSzP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jan 2020 13:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2ErmNV5ekEMfsTNV9na+RR9wyuOVCkqSRBtxE7ukl42Uro/8ZXhnYBQu9Wsglp5JkXQ01mhzKvUHD7SMOBAGfot0AVJ2Tmd6WzBjna54eDQIJT+qlkAIJfksOpLdK6Zif7jtJFk7pRc/c9CdHNvAP7MC5P5Nj/RZTomonkqof0MPdr3F1tUgGIe3Dzy4ukJ6Wu3OUfsxki8cUuyawrXP0WV2JodtOgBPpir6lSnUp9eCFwA6RezcRyYkYIczHbGaXbKPd6YNn0T2fTRMsd8Lvw+XHXdz5MWFEqodYmCgP9k9i9ljruV2sznBO/92mb6TkLKkNgMfD4bT5xIZZ22fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaIoGsb2MCOC08ogJ22kPVMeNT+H3Jty/6jFGQYikMs=;
 b=iosBCIK+SRD2wD5WWVMsQFu4k3k6AvnonwplPvn0IIYSpiy+0i62DI+dgd52rkaA5BPKYxWEQDqP2Acs2JT+KKwssSwKSpitji5r/ZfBR2V6XHqPgowVd4xs3kPo1KyxMdFgoTmhf6Rm5Lx9NNdlc3Ud6fyRqcNMjLB6rkmcIpgNy9j7ypWUbjAEjz0b1hVNhxKqnB3069G4pSp+caFXq43cS9sT10FagRu9voaS87ZzxZl8eJ7obTAHFuc6upYVX1c4trgWC9fo90bUXP15UvNTNzTERvayoK+gvHoHgvcebi97ICEnLzDUDQLfhvf369r/uFnNoNqpldFVROGpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaIoGsb2MCOC08ogJ22kPVMeNT+H3Jty/6jFGQYikMs=;
 b=t/lwjvqTxzkNQn4ZmqnJpZT00ScICvxJAWw+OJ9CDzYg5x4sGEMsN580kAyKndnuF/bEwZBQPXqtbFKuiaJGVfWsjSNAySKahjxcyvvCHVALCiKjl0DDCTjW4DC7QVxRHUHiXvCWBWSSHlcqFvskydfv/175aYfkkbckg5eVUxo=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5199.namprd08.prod.outlook.com (52.135.106.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Sun, 26 Jan 2020 18:55:11 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 18:55:11 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0201CA0036.namprd02.prod.outlook.com (2603:10b6:803:2e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Sun, 26 Jan 2020 18:55:10 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/3] leds: pwm: simplify if condition
Thread-Topic: [PATCH 1/3] leds: pwm: simplify if condition
Thread-Index: AQHV0tbreuTes50WCEmXmy223iKll6f9TouA
Date:   Sun, 26 Jan 2020 18:55:11 +0000
Message-ID: <20200126185501.GA2569@labundy.com>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-2-uwe@kleine-koenig.org>
In-Reply-To: <20200124165409.12422-2-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:803:2e::22) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c86d6b7-7c39-4ca5-b30d-08d7a2914511
x-ms-traffictypediagnostic: SN6PR08MB5199:
x-microsoft-antispam-prvs: <SN6PR08MB5199D94623F6377BD6CA1DE5D3080@SN6PR08MB5199.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39830400003)(189003)(199004)(71200400001)(8886007)(66946007)(508600001)(52116002)(36756003)(8676002)(66556008)(86362001)(64756008)(66446008)(66476007)(4326008)(7696005)(81156014)(8936002)(1076003)(81166006)(66574012)(6916009)(2906002)(316002)(16526019)(26005)(2616005)(956004)(54906003)(55016002)(5660300002)(186003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5199;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmfZTJcJPEiOe5aBYZPEs0lHOYm0j8LPyiYAdMCojSk+aT4oSQXOfukOHj6/ww5dqKld0fHWoopFNY1gcs5nQ3sb5q0UGSOlzxqVsk3Ko3WkIHPjBbVHmbuwXibMxECaIMm3dW4h+Pwoqx1F3qioVOut0yokzGxnAhHyr1eZYIa7YCYjfci0I/na2glGmGoLFrIl3DZhaihS1NtYNwoy//TifzQ42rfzkAgTHDUovUr7stLRkeS4GPqqpb+OL9Mlny9is0iZT0YmY8PBY5NLKqLrjvsfYx+s5bWDM97BH2Ms5l9kkvcPeTFoBLy68KpOdvRZxO7LS/polqmAw3UHgxiK1Sq2CQ3UsAVbgcTrD7ZBtwQ73lB7LnpmMOwYtlvoAxuAMGdB/rpUpz3xMiyVwYwkx/pVAwfvoE9U0oQckCex0rdbTSDvBWmI+CzzGol6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9F02039CBBDAAC4BA741B63454FEF5DC@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c86d6b7-7c39-4ca5-b30d-08d7a2914511
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 18:55:11.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tT4gBm71KzuYxw+zhsbcJcu5W5IYnHchcvbsIYCtWCHlT50YVLJaeSEH7meNu6z4iXkJbTmsFkrDDpgF6tQkDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5199
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Jan 24, 2020 at 05:54:07PM +0100, Uwe Kleine-K=F6nig wrote:
> .pwm_period_ns is an unsigned integer. So when led->pwm_period_ns > 0
> is false, we now assign 0 to a value that is already 0, so it doesn't
> hurt and we can skip checking the actual value.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/leds/leds-pwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 8b6965a563e9..b72fd89ff390 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -102,7 +102,7 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
>  	pwm_get_args(led_data->pwm, &pargs);
> =20
>  	led_data->period =3D pargs.period;
> -	if (!led_data->period && (led->pwm_period_ns > 0))
> +	if (!led_data->period)
>  		led_data->period =3D led->pwm_period_ns;
> =20
>  	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
> --=20
> 2.24.0
>=20

Having tested this series with the pwm-iqs620a driver in development
(v5) and some actual hardware (IQS620AEV04 connected to an n-channel
MOSFET and an LED), let me add:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
