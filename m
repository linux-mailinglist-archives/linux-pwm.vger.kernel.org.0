Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669A2239D29
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Aug 2020 03:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHCBNs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Aug 2020 21:13:48 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:32557
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHCBNs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 2 Aug 2020 21:13:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhkun7bJ8M2Zc8YtHy7SueZW83LWjAYXuPykIU+zg/LmFexkYQDxBDG2SxkH5ZL7pZq6gjd7+NzPmvtx3adrajswqVu5Wxj5QvCZgThcF2dp2hfGi3Uz9UJbOyBAU6NKDAWPpIx3mh4u8DVhJNHEc+F/3foV51dDPF8Lfcx+yth5d30a4VZyHJpSQ6dxk0V7syRjJxzAySIwfTYZhAyOqSqFAB25Vi3p9v+rusiBxxPUM4rYXOGDq/VH21OBXBpTwnwihw+3kL/nXwthTOGxRPNxw1sUgBlMT8fXl9Buo/b+4cldSDwccpKmazWezmiRz4sTAh/0NaQuURw3zEmTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yy2poEazCjryjAHlqIjqlio6QfnzU/zy9L82bZ+cUg=;
 b=g8hu4T9oQOR+ovJ8vIOtjwslb2ermRssa2pVy8J+YBm8H0wnrMgMgohIPsPk5JDyJFsRgORmjFmGiYYPWKtwkPOVI/Qw53XTUFEPiuyMa2gzzTCefaWi5IfZDqFwlagNzolQFq/ifrQXLQpQh37FEGHKp/r8w0H4A2KTtFYH0zHQhaYyfKyyICvHCMDdBPMua+0Ylirnhf2PtY2XqYfJrBZTy88XGKAHnmmKOysD6QJ7ano7QXFu8blIc+a9mTB8ZeiwbF6OB8CQl1NW5tuRmMkOg8AOtovMq4VwW3jU+YcSGW2BQuJiwA6Cxl4/2NUBofdpg7kTmIzRv/pHuK2TLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yy2poEazCjryjAHlqIjqlio6QfnzU/zy9L82bZ+cUg=;
 b=Q83aewR7gQbqs0wXAteEIz6a7Ef29AxtrxcFI1plHHKVQdgZNmhgTfNw0GCvkbyDkwcoKSg/kQ4+fU19Zp5yjBYQWxcahhvrUZOdFBlB/x9zpGdJfQLHvNqCjrJEaH4r25K/ja99ZArT2SRe1EDM3da3m+p3Dgn1n8CEWYqWHag=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DB6PR10MB1589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:37::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Mon, 3 Aug
 2020 01:13:44 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 01:13:43 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
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
Subject: RE: [PATCH v18 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v18 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWZVgP/N9464pJ20GmrAtQIjgduqkeGogAgAaiGgCAANhxoA==
Date:   Mon, 3 Aug 2020 01:13:43 +0000
Message-ID: <DB8PR10MB34367DC3A171A65766056495854D0@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws> <20200802115422.GB1090@bug>
In-Reply-To: <20200802115422.GB1090@bug>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ucw.cz; dkim=none (message not signed)
 header.d=none;ucw.cz; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b79a5a-0407-4878-afc5-08d8374a7731
x-ms-traffictypediagnostic: DB6PR10MB1589:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR10MB1589E837785B041B82C5D34CA24D0@DB6PR10MB1589.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyNPtoPcPRQ30SfzgI1x3EPnnxqybsH5s76MUsDjl2IWuTU+pGt+315hsHPtsBBlVhVkZVJHb+M5ZNEySZslaD3Plm2VtSikGifgmXd1qyzmBXunCJurdZr6i92D3noLBPQdekeWWhtJJK3WlNmuaRd7b/aAOmvXHwckgWgd7mFRT/BwsKxHYpaWvZulsyERH3O3N/yrLWDCZ4d3CPausbjMEnnRiZ8yfuoCxXMUGNB3nYp9jPwyRFqD+u9wq6A1P+RlVuxA43/46zi6AA/+MDt+Vrto/qEKQVO6NZL/qfLLVh15q69eG7c4USCBTsky1UAjJFpna4DPEFI988NH1cVP4rGlxf3zxggcLFkocNNN1VZFxAfkJgfTUduxeD+U5pekifRI2Taa+Uavfuv6TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(5660300002)(52536014)(55016002)(66946007)(9686003)(66476007)(66446008)(76116006)(64756008)(66556008)(86362001)(54906003)(33656002)(7416002)(2906002)(53546011)(316002)(110136005)(8936002)(71200400001)(478600001)(8676002)(26005)(4326008)(7696005)(186003)(966005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8XQ2uql5cje3dryHWOeRy0GS+SmDkRBOuiUDkiso5FIOXXaXw9gsVyF1X4zak7PdVbJQ0POHlb6WDUEBoFJCXF1J/0XC2YLgTin5q6oUH/W32E3deThbHU7Q2QijbFYRn9OaKINzUltEMtlAnr5vh/fN1yl4FyuXWvqdDby7Sgz3eKNAwfnYq/OvwcEIL+7vky0SetzwWuRiwg1BcQQnl1lFNiVa1mINoLt69hmZ2rA/RRJrjGRy5c8bSOpI2ALouydOh9qnaQYksNDe1nuHgtVJkkJjQj1lpGpYhgjrp4xCArKsuzo88lWu2jVd3TspjVBIS7KSvFgTmRoHUQPjs4oWxPsesD5r//do/PMYMFuDAhIqSkWWuJra2m9tNbGFPBrp2xB28Eoom6iLcATEx5HFTcfpkbNa38MELoYJQ6nl4BnaO7bwo/YsIVsSihhuUfoFTrFK2DwuPNT9XGPgF+2jMfR2PehxLFjxYTbXzCuNvTSt2xxzFYYQ+S65V0ovVKDzL6Yu1V6S/DJhr7+0lAP0QUClcDHps8ec+B81JU3LKD6ZDg1IDWCJIUsr88lNwWP0VPWLBzZXG/Thgen+v8SHYn4rBuVSZJ64F7j+mICoYcD+thdi7a3eg+9PtRiBuJNzogOvvpjI6DKChrqtqg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b79a5a-0407-4878-afc5-08d8374a7731
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 01:13:43.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4RMAHbT/Rd31HmB6Ssdr6x3hUMGaUPAPmFQxQjygnM2wAg6x7V1B8qzNii3tZ9ker9ja6Q1KlPhjqt59c+pbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1589
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, August 2, 2020 8:54 PM, Pavel Machek wrote:=20
> Hi!
>=20
> > > +static DEVICE_ATTR_RW(ps_seq_id);
> > > +static DEVICE_ATTR_RW(ps_seq_loop); static
> > > +DEVICE_ATTR_RW(gpi_seq_id0); static DEVICE_ATTR_RW(gpi_seq_id1);
> > > +static DEVICE_ATTR_RW(gpi_seq_id2); static
> > > +DEVICE_ATTR_WO(patterns);
> >
> > Should this be a binary attribute instead of having string parsing in
> > the kernel?
>=20
> Plus... is this suitable userland interface? Should it be documetned?

It could be used by sysfs interface and string parsing, and I added some ex=
amples ahead of id and loop attributes, but for the patterns yes, it should=
 be. As I have already added some comment before for the first comment from=
 Dmitry, now the upload effect covers this attributes, so I would like to r=
emove them and I have added some code a little bit more in the upload effec=
t function in the next patch.

Thanks for your comments.

>=20
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

Kind regards
Roy
