Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7382072C3
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2020 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbgFXMEd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Jun 2020 08:04:33 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:32802
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388522AbgFXMEb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 24 Jun 2020 08:04:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq3GgHb3iHcPnkYZd2lMVB5kzqq15uNPphBUr8YggNOOvJFft/4tnvotJ7sWTbR50HPwdkrguRlPDxDqg+pWAX3n5SpytjbQLVvLKs7PNwfR+Gq9LIfFxsuuwRW6hLRknWQhqAu2kna+whbFdnqYAV3MNN8lG9yDy6Uug1sfmqyLIWoVK+d+SXIoeI18TSM8SpSkmgcB8g5gaImbW9TlHlPlmr8mZAaZU8sYv3Bp2RdL2yUwl/HUA2Sx7Z1RWC0aN7E+PiLzs7FCKNY11dQdO0O/I3lCInkl//XF8UKlHscaG10YssaWGNs6Qjtb4yhoBu/M6UJRdSL9GAn4nl5M5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFpvu0WFJcI5hP1acYFbk98nI6Cbz/9Cz8j3+nMUhqU=;
 b=mp0Btn4Q2sWFnsbxG2lc8H0UjyGmKTfMRBSdCeytvqb+qGr+Kmj+Nju7/rRh//+5d5M9wXNi3vdtuVtpyKln5JjvwxcpN+qhElwmwIKzUiafHJ/dY6/4YWSg4ihlTajjUTO/XrZ9uiDgjS+nSSKgbAEb7P/CVgxNLU7u+1MDko+O53HFr5oblR81LSFAUQ6O6uahgT3zJchowjHeqOypla+7mjRFwgOgoFnah3x/69AowhHH8vPPZsZzXRYrRr5KOuKtG4jp/066ediidN1TVqo6TXM35yz9As3xDEUhg3Ii5Vcku5EgiY8hFz0arM+FxTYk3YOua3tsiXrDDmajrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFpvu0WFJcI5hP1acYFbk98nI6Cbz/9Cz8j3+nMUhqU=;
 b=qvjLO7bOn9ov1Gj/J3VN5p316fr0eYpfr4Bhn94Hj4W+tCwUDwaSKS43IWX12z5V8CUyqNfJhVR9eyKnuo4iZ9JcfNwfPGsd/WDYqZ4uSFq1Byb4zrYM9/xBAYfI08a4AJDPlTNffKmOFzOWyYQ5n5WhJMPfaugqLhq4R+vNPEo=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB8PR10MB2891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 12:04:24 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 12:04:24 +0000
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
Subject: RE: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWQwzBfFR7uhdm1kyQ3q9kXzA/B6jmUoyAgAC/zIA=
Date:   Wed, 24 Jun 2020 12:04:24 +0000
Message-ID: <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
In-Reply-To: <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37565279-34ff-4415-f879-08d81836bcab
x-ms-traffictypediagnostic: DB8PR10MB2891:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB28912A2B21CD6479AD90C92FA2950@DB8PR10MB2891.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52r3d9dlD53LmiKaV++M7U8KT4CFDJC/v4P6NyK7eGPSKzR8O/xOuHZ+3T076rpZ6AxxbNHZUmNcNrOEwE/LH8Gi198ADwV+LeBZhLQvsZAynNuNbqaNVKLuZHvUQnBG5eQRJDx63BM0a3jWvtLHB70mIpOjWdfPsixqv7mby1hc2JN117KuKv78KJQmBtSQzrdyEdqsALMOZIlEcxKvy6Kwx/2plY20A45VuIanw2WQVOtiP1KB94i4Ar/jQXPYiZ61727/JBbiRCRx1fwhJm9MqMi7pVSARfyHMWpVeH3qciWNHTjyxDX+AjJcIGZAulSApmpnDAyV+6Lpfd14RSiCtW9m2mveowp2P7unHcKN+waamyXeUyIqMeYT8ZP+OQzepA6JSIhxYBlhxt0ORQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(186003)(66556008)(66446008)(53546011)(66946007)(26005)(76116006)(66476007)(64756008)(7696005)(6506007)(110136005)(316002)(2906002)(4326008)(5660300002)(8676002)(8936002)(52536014)(83080400001)(54906003)(55016002)(66574015)(83380400001)(9686003)(86362001)(478600001)(966005)(7416002)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6QZ3MGIPtdhyizFe5D/HQWzLJu6jCbDasYkB83avfQQxeEaOZHRedZkEU5TXz4oo89xJuZw9rFwQbvLCpjx7o1Y4RCc+Xe/aNIvpGNucIihITqV/j1BN7eKyI8F+Ss6cGcIq7XsavUP37YvTT9QfEMD2G8UzqUkbknpixzenDgzR3/JBoXydhJUSlR0J+SYj03/BPeX9Ucf04t+MIuCT2vagsAoTWxMDArhUlJemuNx7wOlebMrNW6RDoEpI+X9SHi98KhYmI/L/0cQHcCgQ7sjpwlP3H5MMUOPp+cUonR9TzrTzfQ8g6dWf/ZcVprW8UpBn5BIbuJnDAd2ZmY9R/LitFR4SZNS65A44Q21zZIPj1/TPGC+sP8sAfFm15HHfOBhy7CQpbfh8WyB301MiBNDMbhtsoKa3RrZNmy/ezh5K+S7QHlpQcvVuRXdO0ZUvUrss++IaANodnQm6NTDYCmMddYiRozmGAbpRoa2ibJQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37565279-34ff-4415-f879-08d81836bcab
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 12:04:24.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdEhxXQnMNEzS9reOvo9IZC8ec9Ybrk5yb/hITfxgdHT9bhLEqDEQeWJN05LMBrBNewMP886FeEMnSvDqlrtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2891
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Tue, June 23, 2020 11:41 PM, Uwe Kleine-K=F6nig wrote:
>=20
> Hello,
>=20
> On Mon, Jun 15, 2020 at 08:40:23PM +0900, Roy Im wrote:
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
> >
> > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
>=20
> Just some picky comments below.
>=20
> > +	error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +	if (error)
> > +		dev_err(haptics->dev,
> > +			"failed to apply pwm state: %pE\n",
> > +			ERR_PTR(error));
>=20
> You can save some horizontal space here by dropping the \n after the firs=
t comma. (There are a few more occurences.)
>=20
Ok, is this what you want?
	error =3D pwm_apply_state(haptics->pwm_dev, &state);
	if (error)
		dev_err(haptics->dev, "failed to apply pwm state: %pE\n",
			ERR_PTR(error));

> > +	return error;
> > +}
> > +[...]
> > +
> > +		/* Sync up PWM state and ensure it is off. */
> > +		pwm_init_state(haptics->pwm_dev, &state);
> > +		state.enabled =3D false;
> > +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +		if (error) {
> > +			dev_err(dev,
> > +				"failed to apply initial PWM state: %pE\n",
> > +				ERR_PTR(error));
> > +			return error;
> > +		}
> > +
> > +		/* Check PWM Period, it must be in 10k ~ 250kHz */
>=20
> The unit of a PWM period is in (nano)seconds, to it cannot be in the rang=
e [10kHz, 250kHz]. (Is this too picky?)

No, it isn't. The 'Period' should be changed to 'frequency', I will fix thi=
s as below.

		/* Check PWM frequency, valid range: 10k ~ 250kHz */

>=20
> > +		period2freq =3D 1000000 / state.period;
> > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> > +				period2freq);
>=20
> Doesn't the compiler warn here about period2freq being unsigned and %d be=
ing for signed int values?
>=20
> For my (non-native) English ear s/Not supported/Unsupported/ sounds bette=
r. Also my eyes would be pleases by a space
> before the opening brace.

I didn't see any warning message, but I will change/improve them to proper =
one and the log as below.

		period2freq =3D 1000000 / state.period;
		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
			dev_err(dev, "Unsupported PWM frequency (%u)\n",
				period2freq);
			return -EINVAL;
		}
If you look ok, let me update this so.

>=20
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +
> > +[...]
> > +static struct i2c_driver da7280_driver =3D {
> > +	.driver	=3D {
> > +		.name		=3D "da7280",
> > +		.of_match_table	=3D of_match_ptr(da7280_of_match),
> > +		.pm		=3D &da7280_pm_ops,
>=20
> I don't like alignment of =3D, but I'm aware this is a subjective thing.
> (The reason for me is that adding a new member that is longer than the al=
ready existing requires touching all lines. So I
> stick to a single space before a =3D.)

OK, I will do as you said.

>=20
> > +	},
> > +	.probe	  =3D da7280_probe,
> > +	.id_table =3D da7280_i2c_id,
> > +};
> > +module_i2c_driver(da7280_driver);
> > +
> > +MODULE_DESCRIPTION("DA7280 haptics driver"); MODULE_AUTHOR("Roy Im
> > +<Roy.Im.Opensource@diasemi.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > end-of-patch for RESEND PATCH V13
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
