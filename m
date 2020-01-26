Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5D149C72
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jan 2020 20:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAZTPE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jan 2020 14:15:04 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:14177
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgAZTPE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jan 2020 14:15:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiHekXxGZ0fxkziEtiznGdkz7NNJ/TJjzIlI9T6nCxoKCsLMhtz9h8MfBAtYG13AmbpBmZWEAeNvD6uXqvzDDK1wqeSFgt/cUoKcZqBOTfY70UosVmyMFfm6ilaO0otN0LDE4EI5c5PTe/+OPRmYqy83Xa/SRhOFlec0H7ks6/mxN8l22jIQJO/zkqxsEHwuEJiwbY+8Ij3h6B0t4lAwpgaALyWaK3JmPf4jhzVowIg43Bqzn0xGT/55uWA6vaUi+PypS7/YoC/8ZXINp1+d7F0BUmauVy2dITN/p+U94uOInnpdvI9WoO3aeHA9ytvm1qOgwVQ9oMobcnY1SET9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJouD6xsrxD8v8FiiOzxZv900E9JjszyccU77AgvUrA=;
 b=hddq6o8U9tp8DUCDXl0Q898CiFX2QTipC4rKYSvqnHzLyOtFOYIsiulNYwio4B0OnudKO/kPvT5uVi3IGL+K92qYUzjOccDQI9kzWuMGDe41ZWEctBjebcXUdgU68jpBCgy6A05dTV7qNVlTZe2knsWzAz8Sblr/HpzMw2RqizspYlP2SJshwljhOmTId/MPyEU5NJ8zYJiUNBxcxIT0641I/mT2IOSFjygqi0MOH+JRN3fr7cQx6PVKtNS0yHpRjd0ChkLvFSx3giJxTRkqu+0J2Y6jATJKoUZYyHMMwLQElJs0UbFWloE/ARLWlLlNCVUwZyqFU7/rWnc6qFk9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJouD6xsrxD8v8FiiOzxZv900E9JjszyccU77AgvUrA=;
 b=hNQpEHta3QLgEffmty0j6jPdi0cc2eT/fyZBXWHKk5v75h4Z5nbtWdgg98GOBVzvw8hG1ddUOY2kzj+gRrxTgO07CJeAtlR7Udt8l8Xd7s168dA4QzMN4zk7ML7bYwKBF9uj/kuIvi/bPhzw1yjueDGur7lR0itz9XxntoXznso=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5168.namprd08.prod.outlook.com (52.135.107.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 19:15:00 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 19:15:00 +0000
Received: from labundy.com (136.49.227.119) by SN1PR12CA0043.namprd12.prod.outlook.com (2603:10b6:802:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend Transport; Sun, 26 Jan 2020 19:14:59 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/3] leds: pwm: convert to atomic PWM API
Thread-Topic: [PATCH 2/3] leds: pwm: convert to atomic PWM API
Thread-Index: AQHV0tbsTwyVxglvL0CE8Blw/jRXBqf9VB4A
Date:   Sun, 26 Jan 2020 19:15:00 +0000
Message-ID: <20200126191457.GB2569@labundy.com>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-3-uwe@kleine-koenig.org>
In-Reply-To: <20200124165409.12422-3-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b7e9bec-70c6-4ba0-335f-08d7a29409ff
x-ms-traffictypediagnostic: SN6PR08MB5168:
x-microsoft-antispam-prvs: <SN6PR08MB5168209D323D0BDB94F2BEFBD3080@SN6PR08MB5168.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39830400003)(366004)(376002)(346002)(189003)(199004)(6916009)(66446008)(64756008)(66556008)(66476007)(508600001)(66946007)(33656002)(2906002)(956004)(2616005)(4326008)(36756003)(26005)(186003)(16526019)(55016002)(86362001)(1076003)(8676002)(7696005)(6666004)(316002)(52116002)(5660300002)(8886007)(81166006)(8936002)(71200400001)(66574012)(81156014)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5168;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vmf72sgAu6gO+MqjqEksmgZfxkZkG7pW5buvcSC61TD0A2fx+f5QczvZaitMqApEbg4bfio/O8cAvFKsrF2TQA3Ln8ptxQHQa55WrWUJURd+KxzcT4e5OLqtS84xio0/SO05afk5UHQs04AyJ5TNlUM4mDU6wJvsZvyZi2tTufip2Z/FUwMa9vHigqsXAkPysLyp/Qhs7Fqqv5ftnCZA2a82BlTzlSw9xBnBvbvb6EVs+5rS4AHi3DJd/kQnMZ+Kg0135UEyCLSbLaBfW3Ki5YX/WDM0WN6F/7x+TCqKFZ2nZjlGdgRfQqLLiuuEtsPvAghUYvsEoBGMr955vY5TVPwOZUvXPIS8a04+0u8bfxz247p1dVRXLfMufUhUsLOLWlXJsoTD7/+P4QRabMGZcQxQRg2uODed090Y0ApHm1hEIxlZNtpJSENok1uYXxD3
x-ms-exchange-antispam-messagedata: y5XDwbBpygGYGx212dLu7D2nu8vQ3E/gXJ/JPKkr6pEFGDNnyK8OxHcAk5f+zyQhcSUAXbqUiJKQiv+m052D5y9idtA1Lwt0OtLbn+CV1Jypi2thKXWQ62KzZZruaEvfgvK46WZw+v2VBK7twG28ig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FF585192A2BC4944ABF2154D874CD0B0@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7e9bec-70c6-4ba0-335f-08d7a29409ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 19:15:00.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gL3ithJ6yYRw8bJvxnKdNn18n9Y74lU7v2ZQy8hWAKyP4QT1KCiCRxg/umHHJByAU6cxIzdJU025KrL4WDRpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5168
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Jan 24, 2020 at 05:54:08PM +0100, Uwe Kleine-K=F6nig wrote:
> pwm_config(), pwm_enable() and pwm_disable() should get removed in the
> long run. So update the driver to use the atomic API that is here to
> stay.
>=20
> A few side effects:
>=20
>  - led_pwm_set() now returns an error when setting the PWM fails.
>  - During .probe() the PWM isn't disabled implicitly by pwm_apply_args()
>    any more.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/leds/leds-pwm.c | 41 +++++++++--------------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index b72fd89ff390..9111cdede0ee 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -22,9 +22,8 @@
>  struct led_pwm_data {
>  	struct led_classdev	cdev;
>  	struct pwm_device	*pwm;
> +	struct pwm_state	pwmstate;
>  	unsigned int		active_low;
> -	unsigned int		period;
> -	int			duty;
>  };
> =20
>  struct led_pwm_priv {
> @@ -32,44 +31,29 @@ struct led_pwm_priv {
>  	struct led_pwm_data leds[0];
>  };
> =20
> -static void __led_pwm_set(struct led_pwm_data *led_dat)
> -{
> -	int new_duty =3D led_dat->duty;
> -
> -	pwm_config(led_dat->pwm, new_duty, led_dat->period);
> -
> -	if (new_duty =3D=3D 0)
> -		pwm_disable(led_dat->pwm);
> -	else
> -		pwm_enable(led_dat->pwm);
> -}
> -
>  static int led_pwm_set(struct led_classdev *led_cdev,
>  		       enum led_brightness brightness)
>  {
>  	struct led_pwm_data *led_dat =3D
>  		container_of(led_cdev, struct led_pwm_data, cdev);
>  	unsigned int max =3D led_dat->cdev.max_brightness;
> -	unsigned long long duty =3D  led_dat->period;
> +	unsigned long long duty =3D led_dat->pwmstate.period;
> =20
>  	duty *=3D brightness;
>  	do_div(duty, max);
> =20
>  	if (led_dat->active_low)
> -		duty =3D led_dat->period - duty;
> -
> -	led_dat->duty =3D duty;
> -
> -	__led_pwm_set(led_dat);
> +		duty =3D led_dat->pwmstate.period - duty;
> =20
> -	return 0;
> +	led_dat->pwmstate.duty_cycle =3D duty;
> +	led_dat->pwmstate.enabled =3D duty > 0;
> +	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
>  }
> =20
>  static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>  		       struct led_pwm *led, struct fwnode_handle *fwnode)
>  {
>  	struct led_pwm_data *led_data =3D &priv->leds[priv->num_leds];
> -	struct pwm_args pargs;
>  	int ret;
> =20
>  	led_data->active_low =3D led->active_low;
> @@ -93,17 +77,10 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
> =20
>  	led_data->cdev.brightness_set_blocking =3D led_pwm_set;
> =20
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to the
> -	 * atomic PWM API.
> -	 */
> -	pwm_apply_args(led_data->pwm);
> -
> -	pwm_get_args(led_data->pwm, &pargs);
> +	pwm_init_state(led_data->pwm, &led_data->pwmstate);
> =20
> -	led_data->period =3D pargs.period;
> -	if (!led_data->period)
> -		led_data->period =3D led->pwm_period_ns;
> +	if (!led_data->pwmstate.period)
> +		led_data->pwmstate.period =3D led->pwm_period_ns;
> =20
>  	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
>  	if (ret =3D=3D 0) {
> --=20
> 2.24.0
>=20

Using the same setup described in my response to patch [1/3], I checked
the following:

* LED appears as expected with brightness continuously swept between 0
  and 255 at fixed intervals
* I2C traffic appears as expected for random cases of brightness being
  changed between 0 and !0 and back to 0

And so:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
