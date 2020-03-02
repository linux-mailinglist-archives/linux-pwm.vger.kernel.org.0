Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08F8175198
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 02:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCBBwk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Mar 2020 20:52:40 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:63139 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgCBBwj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 1 Mar 2020 20:52:39 -0500
Received: from [100.113.5.69] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 86/14-05601-0E66C5E5; Mon, 02 Mar 2020 01:52:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTe0xTZxjG+XrO6TkI1UPB8MnFS7e4BGmBMeZ
  ZdIubizkZ2zK2/0DAUzjQxlKgLQM0WVgMqFwG3SDItSriGMORgTBxMBbk6oBODAyQ2iKXQRkg
  KKJTcKc91W3//d73efO8T958H4GIq3Avgk3TsRo1o5IIt6CKANEBqTnuaFRgZu5B6mHFTZS6c
  XEOUKeq6oWUea0LUGOrjzDq9vVyIWUy1QJq7dlTnDr9YxlG5ZctYNRS/wxOPW+9hlO/5WBUY0
  MRQj25XolSd/TfgEMkvTyaidMtpSacbqg9K6QnRlqF9NLgIE5X9oXR7RV1OF096k7nbwTSM4/
  bEPpBw066P2sR/cQ1HFOq5YlpxzDF/dlKPKnTOc24+jPIAMV4NthCALIagZOGVQFfdKOw7Jcs
  lC8aAXya90RoK1CyF4Fzt5YwWyEmCwSwefGyo7gLoMWiR7KBMyEk/eG9knqBjT3IZLgwYbR7I
  WQ3Bo1f3sFsgjt5AJ47P+YYOggNP03jPB+B98tr7UYo+Sq03Cqws4iMhM+n8hB+W4sArrdXAJ
  vgTL4NVyYfchsILq0vHB7xsbUR0hOOTxvs/pAk4aVWI8Lzdjg/tWnPAMhomGEtd/T94cAf04D
  n3bCm8LSQZ184ZMhx9D+Cjwa+x3n2g5auG44ZCl7KybRHgFzmzY50vq2CTROTKM974fBql4N9
  4Mp8vv2kkGxCYeHQPawABJb+JzbPMjhaVCjkeR+8fGEBKbWfwg32lUyj5wFaC96Sa5TxCl0Co
  1RJgwIDpUFBwdIQjvbLmBNSuYxNkcawap2G4VQZk6qVadMTYlSxMjWrawDce41Nxo5fA02GZV
  kH2EEIJNtFPskRUeKt8sTYdAWjVURrUlSstgP4EIQEipblR6PEbho2nk2LU6q4V/9ChoSrxEP
  0+DNOFmmTmAStMp6XbgIpUTBfcRERo+pENevlKVKz3BBpG1KkqF9avPg7Q8DXy10EnJycxK5J
  rCZBqfu/bgWeBJC4i+ZsLq5Kte7lJisXQsCFyP0zwhZCx/wreWUIMqbQmNDB0jiXPfK6yM6Vk
  QL9jvG07MgPIqyYPnQxgD31q6mrZ2d6bzEh9j9890xJpWbSzSLZeH9rT6p/sKrq9+iTRc19Jm
  ExkiX44gfPRX3i56+Etw8yfh5Vmy51AyHvjJd67P94pVbw+jPXYydWus0nnY4EOad6F27tfy+
  /pe0wNFxRujfvbTPHBG+rd4r+atyQ++BcqPrqtLU84rYHE6O6gqe8670tMm7NNLxm7Q6Z+Tv8
  wnLjrorimo3v8t7wj/1WXz22XlYz1LhrYs8gtZb3tc+ZlrCI3uDOSHPlpjX06uyhAONri6t1l
  n1nP8yMnf2r2yzteXM9JdM7MetTo0vY8TEJqlUwQX6IRsv8Azvi7LG2BAAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-13.tower-239.messagelabs.com!1583113951!147620!1
X-Originating-IP: [104.47.13.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6872 invoked from network); 2 Mar 2020 01:52:31 -0000
Received: from mail-he1eur04lp2059.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.59)
  by server-13.tower-239.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Mar 2020 01:52:31 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE+CTxQFLZfEbZq7XG+nJ3m6LT13oYgY2VImRlHmK9SnDRdPM9sP4kPOw+uVxG2JZBeyinDtKAZsnL+PJoS2luPem9gMY8FQh38XvmrxpFu/Z1Qx5j6a4PQURD6mcL+F8asCtp4nBQ7sk6OJ36/tYJGhrlHWOLZ9G3UC7BJjs1qlC+dFiQ2kxQrFVoR6LakcjN0AtwavpWCS5DFHd4Xj6bmw36wtnXhx+4SmnqVSf5+WjIk56nSQuV190FoSi0g2jBYHtnlT/9mve+Pg19FmsmaFteappme30YLI0PeA6c5681b1vFVhuBSHo30uHk00HtDE8APgtjTyosN3f66Kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzR52RVdkFR2fDwcqKqE0VSA/3Lx8XCCIlyDpA2CJi0=;
 b=b/h7oQw6NGnnNVLIacANUF+DnwYeqxkzWWvdyGwWavNiZXKlQStk2B5UjlMZb2FMCkLXInD4vc0RkrdXD3RmU2XZGu6k0oWfQ49LGn355OE7HHoJqgyrciRWVMCqcbshyWEH7U26q7Yvc7qKkxbDzN65S5bBoxhVWWqmc6deYtmSZSLVRgiehFccpzGmVCT/5Us8kRbA2D0zS/JxydB0s2Qmm4/wKL17NP0XqMwyBGMvIsQWAfLI5OgLRzhWBanYwqZdTyvPRp++GNZvpT4F+Ux84cAarjiU/Xm7tQCFmxDtPC2C/IUhMRnKIsYzo+Ljkaf9seL39bT1xPZxozEklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzR52RVdkFR2fDwcqKqE0VSA/3Lx8XCCIlyDpA2CJi0=;
 b=x38BGoqj5+/Lb9ZDqM7HZprrhCTT61N77+oO05X5haV5B3mUr18gvWqqpsVzc9Xs1Z6g3YMVfRfYQvgojIEZ/2aSnilAV3IBuTakXcG1REq6o6b7uw0umTSvxPNJQEe4jsmQmbcCuv2MgVxq3YHMMg/AkvFt6bD3QrW1NsgJQiQ=
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM (20.179.30.210) by
 VE1PR10MB2877.EURPRD10.PROD.OUTLOOK.COM (10.255.158.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 01:52:30 +0000
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034]) by VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034%3]) with mapi id 15.20.2750.024; Mon, 2 Mar 2020
 01:52:30 +0000
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
Subject: RE: [PATCH V9 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH V9 3/3] Input: new da7280 haptic driver
Thread-Index: AQHV6JB2B7xCrQY5cUWkQsJbkeg5B6gtriKAgAO3rwCAAueAgIAARgkQ
Date:   Mon, 2 Mar 2020 01:52:30 +0000
Message-ID: <VE1PR10MB30856D67BB5ED36BED574FBF85E70@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
 <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
 <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
 <20200301212025.lw4f6uv453oulu22@pengutronix.de>
In-Reply-To: <20200301212025.lw4f6uv453oulu22@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.230.217.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb544af1-55e8-448b-3a0f-08d7be4c5e48
x-ms-traffictypediagnostic: VE1PR10MB2877:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB287746620B37B0F0A41192C8A2E70@VE1PR10MB2877.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(7696005)(53546011)(7416002)(33656002)(5660300002)(86362001)(6506007)(26005)(186003)(54906003)(110136005)(9686003)(316002)(55016002)(76116006)(64756008)(66556008)(66946007)(66574012)(81156014)(66476007)(81166006)(8676002)(8936002)(2906002)(66446008)(71200400001)(52536014)(966005)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB2877;H:VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7PZzOPwjQBXolcNLX+FgYDR6zqvSJTo/ngo1JkdsV0oFRzpIh2RUKz+4sdLZqQCAkPOTpdAfw+fMs1GLhHanvqDd6YsFeI5YWKllC5W2Emz0TErbKQjgLiDcs+xOqSOSS4/6jtk0Z9+ayXWbL7k7GWK+7VfF+Av+Od9vHWNvxM/zqooEluy+020QuBK10Is73IQNrPaCGwp+EsREdFd7UHihTa3gHtoEzKhAiGeTTi6jA07mNRkDuMqYH36aJw8mAoN5li91IKtSJYMaeY1IqoQdYVVeg9QcBdWqKijrsQKQ9l2qFx+hzXYcMSEDMM0zhGpqKeAfBtfUfjQAqrR1zhQj38rHtgrm4HCWmpcHzBA2MH4ABD2v7kM9stK3aLqEZHH0tEd8Le0ocOBNs6RGzFbAyqGw2qp+st3/QRTfXkfcHDzoxW68nfAQF4UYNNwy0ls71J25HvOmoEW6b1gemkmo6YcarnLQzhElslvJg46gor2/emvZcg91SRNLU3OHpWUmQxeheGc0z7n62jpmuw==
x-ms-exchange-antispam-messagedata: eeoW2V8NKj0/qGvGl4wWbeZEJw9qFhub9UmnODofs75XmMwmmQhjgjqNuLch3y1RWgmL28IGFyQRgpZx8E7qbCrsRwVr7fXBeafr3SKuIRa8iLF5xE3PBLPVr/zjW9r+Np6EeLrWD+ZHeagh0rDLkA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb544af1-55e8-448b-3a0f-08d7be4c5e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 01:52:30.3129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGiXMW8WHO0TA3bMyKVaV7j5hSRFYreM7yvHwedfHrgMgM0hV7oBH8p/IqksZt/mfkpep8tuaOpkOmSrvurMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2877
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Monday, March 2, 2020 6:20 AM, Uwe Kleine-K=F6nig wrote:
> On Sat, Feb 29, 2020 at 12:59:20AM +0000, Roy Im wrote:
> > Okay, thanks. I have tried to update that as below.
> > Could I get your comment if you still see anything on this?
> >
> > 	/* Maximum gain is 0x7fff for PWM mode */
> > 	#define MAX_MAGNITUDE_SHIFT		15
> >        [...]
> > 	period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;
> >
> > 	/* The interpretation of duty cycle depends on the acc_en,
> > 	* it should be from 50% to 100% for acc_en =3D 0.
> > 	* See datasheet 'PWM mode' section for more details.
> > 	*/
> > 	if (!haptics->acc_en) {
> > 		period_mag_multi +=3D state.period;
> > 		period_mag_multi /=3D 2;
> > 	}
>=20
> Much better. Extra points if you add a link to the datasheet at the top o=
f the driver. I didn't look at the datasheet and
> assume that the reasoning is obvious then.

Okay, then do you think it would be better to remove that comment(the 3rd l=
ine - datasheet)?.=20

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Thanks for your comment.

Kind regards,
Roy
