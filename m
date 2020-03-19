Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3D18B273
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 12:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgCSLky (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 07:40:54 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com ([40.107.20.134]:62689
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgCSLkx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Mar 2020 07:40:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGNgbY9Ta49flkaM2nIjgTt+NYq9wLh41R5lAD9EyRj46jaCMvge+TE5MVNVpZdq4kwfQEL+3R9J2XhlKVvznxhXshMar9hld7kRpPgnYZQehkWr84VCrs2MkkUWuFN7XjFAuF8Yb3EAmv6tcT1AuxkeeftHg5fl7MVfvvDCzwTBhlgRFmT/mcZuXrIfKGmSwN0WJSDgHOrGge0GZfk5sXOs3uq1w1ngPWcuouott2Nd8li7NkcxZkFOaWN8mjoWbJdOKMP1MSeMMpEyBpqRgiU69FQk/aSjtFzZPrE3QKt99altXM5AFX67CELH47ohplqUP06CEm8U55moIvnBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1JMdCzgSmxnlUslDXemgsBTKCWxeoCXEBHNe8q40zU=;
 b=cXvUH43rBxWxJsyA3MT7D8Mo9qr2P0Mfy+spXSRY4npnGF8dQKPVF4O5FWGUpbsdYQlmzYhlksMv6SCDWbZb4bOZ6VlAR+KCM92CyOkbsp7M7Udcg3k/zGgbQ+dLSp9mrvSRvuXaEOoj046N5hCNNV4OGcA8A6Qn3MUclYivs6qez6y7YY4KgOVV22IgZPVlDD4p7EeKqaA0ES+szSl6LTeVcB29Kl0kDhsAkUxgi/0jo7ML/1laLl4oitwctfM6CToXE8uPuw3oYrzPtIKxYYqZoQx8WvEPhhUbiv0Dlr5XgejhA3rmc3ECUhgbK2hcwDE4jpy1+9y8WWRoVsJ2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1JMdCzgSmxnlUslDXemgsBTKCWxeoCXEBHNe8q40zU=;
 b=E0mc/8xaX/FcUVsqgbRpopylcTiIiw5Ht59oE3jGK0P4PXh/Ll4Fow+Ty0SpQuTWt4BnPuHaJemesI5Ajr/kEx9chxqziPZlNL06SdaBuTau7iEkHvEuDTBZhQ1CY9+QaKqaV/CXW16wyuUWE9hqwkuGo3+a/lBTjdzgdH9twbM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5853.eurprd05.prod.outlook.com (20.178.125.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Thu, 19 Mar 2020 11:40:46 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 11:40:46 +0000
X-Gm-Message-State: ANhLgQ1ampUMxo3ccssqc5hopvgbvbautAA67MHyXVcHV71YmYZ6tOjL
        CMyaa3/YHf9vJpvlFJLAsn7zp4FyTyS4dSAfiQk=
X-Google-Smtp-Source: ADFU+vtIv9WWiUZDY1zK2/5Xskt2zIX9VTS8I1COHPgUfpZpdDX7VDSalNnvt8sXvRj9YOkAdKw03F1mQyy6mpu0nPY=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr2405410qvx.75.1584618039943;
 Thu, 19 Mar 2020 04:40:39 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de> <20200318225953.GA2874972@ulmo>
In-Reply-To: <20200318225953.GA2874972@ulmo>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Thu, 19 Mar 2020 13:40:28 +0200
X-Gmail-Original-Message-ID: <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
Message-ID: <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:208:239::9) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f47.google.com (209.85.219.47) by MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 11:40:44 +0000
Received: by mail-qv1-f47.google.com with SMTP id m2so757808qvu.13;        Thu, 19 Mar 2020 04:40:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1ampUMxo3ccssqc5hopvgbvbautAA67MHyXVcHV71YmYZ6tOjL
        CMyaa3/YHf9vJpvlFJLAsn7zp4FyTyS4dSAfiQk=
X-Google-Smtp-Source: ADFU+vtIv9WWiUZDY1zK2/5Xskt2zIX9VTS8I1COHPgUfpZpdDX7VDSalNnvt8sXvRj9YOkAdKw03F1mQyy6mpu0nPY=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr2405410qvx.75.1584618039943;
 Thu, 19 Mar 2020 04:40:39 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
X-Originating-IP: [209.85.219.47]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc59c9d9-1966-4563-eb30-08d7cbfa5c1c
X-MS-TrafficTypeDiagnostic: VI1PR05MB5853:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5853D574983C0F5F95F799A0F9F40@VI1PR05MB5853.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39850400004)(366004)(199004)(966005)(55446002)(2906002)(54906003)(66574012)(42186006)(8936002)(81156014)(81166006)(52116002)(6862004)(53546011)(55236004)(316002)(86362001)(8676002)(478600001)(450100002)(6666004)(186003)(66556008)(26005)(66476007)(4326008)(107886003)(9686003)(44832011)(5660300002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5853;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/KJ7e/Nuj1XRbffIEePkthkH8UAkjoHfWdIlJqky2+8eDFTN4jt1mLidz72ThNfCdl4OrvkC3s0e00afDoYN9h9eX1B4ukxfRrm2VuztDp1ZMlhSj7KovfYz9TJb/YdF7dKn1mdTvI8//KlravPd2Iz2oGEoPaXF5HP9nW/iXKfc3OM4ElHXARoIo8dOrzUvGynVSuLycOKMdvHxFg87P9MgIXDftxfOehwQVsBiX8QLUEVfQhWI5g0zJnWTd3mnWzAtN1tKpLblLKx50v7g5F31GuMVgvugrCp7IdkwngwDgh/2mkvDL0cxCl6dItedv1YuAb1v2VvzncUoUYyL8OS4nkQIuP4hYYedZvCJN78/bR0+E6BwPAiczpz0XXWbDsLIzdD0J9nTQ4IjBPXJEiDuczLhdhC3X8oraPPrzyZnPAMEVqEtenazMbX7b3vz5FR8f0/AGHrXJ9M9eWNuxjYU+sB4tbAVvQGXRWw1WbuFChs4ChRF/kLwiKE7t/MlFWHJUznovtlSwloo/BrjA==
X-MS-Exchange-AntiSpam-MessageData: pwIqy2QTMmaxoGU/pXEbilSJqPa3DBq6Lopz4xLDDdPFk+wpLuJExSgkvww1cioJm9vaxq6EbTCXYZ3Sztbtty03L3bLZJdEUPJjdKYjQ29QGIr6fhtunWNXhQ+3TZx+4dj7yGMmFxFyiUpcD81EuQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc59c9d9-1966-4563-eb30-08d7cbfa5c1c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 11:40:44.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: squJ2IJSilYixbqLzxdJ2vWg/TJ3DRWS2v1aWg2AP5dw6nWZXi7ppesIkALarIbYw3gsyct4LkUfoDBKc5pPZJRKz1P3hR3WnmXNk26tIzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5853
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 19, 2020 at 1:00 AM Thierry Reding <thierry.reding@gmail.com> w=
rote:
>
> On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >
> > On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > > > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > > > Rename it to PWM_POLARITY_INVERTED.
> > >
> > > It isn't misspelled. "inversed" is a synonym for "inverted". Both
> > > spellings are correct.
> >
> > Some time ago I stumbled about "inversed", too. My spell checker doesn'=
t
> > know it and I checked some dictionaries and none of them knew that word=
:
> >
> > https://www.lexico.com/search?utf8=3D%E2%9C%93&filter=3Ddictionary&dict=
ionary=3Den&query=3Dinversed
> > https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
> > https://dictionary.cambridge.org/spellcheck/english-german/?q=3Dinverse=
d
> >
> > https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a ver=
b
> > having "inversed" as past participle.
>
> Here are the first three results from a Google query:
>
>         https://www.yourdictionary.com/inversed
>         https://www.dictionary.com/browse/inversed
>         https://en.wiktionary.org/wiki/inversed
>
> > Having said this I think (independent of the question if "inversed"
> > exists) using two similar terms for the same thing just results in
> > confusion. I hit that in the past already and I like it being addressed=
.
>
> I don't know. It's pretty common to use different words for the same
> thing. They're called synonyms.
>
> > > And as you noted in the cover letter, there's a conflict between the
> > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being includ=
ed
> > > in the wrong order you'll get a compile error.
> >
> > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
> > first to come to my mind). I'm not aware of any problems related to
> > these. What am I missing?
>
> There's currently no problem, obviously. But if for some reason the
> include files end up being included in a different order (i.e. the
> dt-bindings header is included before linux/pwm.h) then the macro will
> be evaluated and result in something like:
>
>         enum pwm_polarity {
>                 PWM_POLARITY_NORMAL,
>                 1,
>         };
>
> and that's not valid C, so will cause a build error.
>
> > > The enum was named this way on purpose to make it separate from the
> > > definition for the DT bindings.
> >
> > Then please let's make it different by picking a different prefix or
> > something like that.
>
> Again, seems to me like unnecessary churn. Feel free to propose
> something, but I recall being in the same position at the time and this
> was the best I could come up with.
>
> > > Note that DT bindings are an ABI and can
> > > never change, whereas the enum pwm_polarity is part of a Linux intern=
al
> > > API and doesn't have the same restrictions as an ABI.
> >
> > I thought only binary device trees (dtb) are supposed to be ABI.
>
> Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> which basically makes it ABI as well. Yes, the symbol name may not be
> part of the ABI, but changing the symbol becomes very inconvenient
> because everyone that depends on it would have to change. Why bother?
>
> My point is that enum pwm_polarity is an API in the kernel and hence its
> easy to change or extend. But since that is not the same for the DTB, we
> need to be careful what from the internal kernel API leaks into the DTB.
> That's why they are different symbols, so that it is clear that what's
> in dt-bindings/pwm/pwm.h is the ABI.

Thierry, I see the PWM core converts the bit field "third cell" into
the polarity variable.
Now I probably understand your sight and agree that we shouldn't give
the same names to bits in bitfield (dts) and values of a variable.

But there are lots of useless "0" values of third cell of "pwms"
option in dts files.

I see 2 ways now:
- just remove all "0" "third cell" from "pwms" options in dts files. I
see this "0" confuses some people.
- convert pwm_state.polarity into pwm_state.flags and use bitfield
directly from dtb.
  It simplifies the parsing logic and makes adding new flags easier.

What do think?

>
> Thierry

--=20
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
