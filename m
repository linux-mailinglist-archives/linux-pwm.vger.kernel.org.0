Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D697C1A0FD5
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2020 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgDGPDW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Apr 2020 11:03:22 -0400
Received: from mail-vi1eur05on2096.outbound.protection.outlook.com ([40.107.21.96]:61358
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728306AbgDGPDW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 7 Apr 2020 11:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj04heUr+HYusf6oIWXyyp5nqeSBxBWFEb6oHSgt3lsvxLMeQpuZXs5NXc3HUW1D718tN/VZ+KpC1ex94ItWdztqL0papBDCFaUoLilr9iNYmEiSWj7mnARPHO/nPgh/XJ4l0JpH/OPOJv0by6sfodHhjQdjrQGeZneV3VhGOJL2+KD3LCeDV4PEn0oHaFc+yYk+dicG+2wP5nUvd35IGm0MFreuuY43AUYRNFA3hbeNQukNOoHK6EB1c7PAcSMQtJYX/Lq/YQsLwxI4UA6OaNO5Gs0q7EoHeuJTEk2NHOs5ncCpLORr7N5TDFjQY0DzTFMKCctkxyskGSZUun+/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7g9CIIbfpIxg6D5MyZN7sIGSrgpv7q7e5h4qDbWFHw=;
 b=EH+Bje7KmYoYa9K/F5yrLx4OtHVjtmp2z6Ts80HZbWPPh3TMUU3zjEj8Hvh5XUFKSMbP9DikaloL0pgFe7T6ZOplImyv19GSz5N9L7LtTr2VucfwcTi8p3KKc4aqugJL1wi306kjHkzabSTDJJfWWQZWpG+8IXFFtZa+BfCn6PdOCv/HzSBiZ+SlGxsOUwziovvMBOK/UKt8RBkX1vj/NQYg5z+jXnCV7LkUin8D/KFg1FHTv4u/XFkOktcW7+7gLQGBb5nHRE7Z44DhYlPhqCONBJlFuRcrXrMhQiQLwmtqkB3gDche3OyJis5l64edYp4b3eLEkGWtu2zwFvIhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7g9CIIbfpIxg6D5MyZN7sIGSrgpv7q7e5h4qDbWFHw=;
 b=ZBNFyjs2OdPdpHMGADX13DDJ6aQHnNfEggEQfBUoPRBm5agjW5FnHpMmJBsygSDlFj8pDz+M6LILGtSwrmntdO/tZQ/EWP6j1z3rhStRr3LoFcPR5PUgFVzVL8TpGT1f2J+wFWUhGPV2DDdcwagUU0TCngGaoVvB7i2rgwIiJM8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
 by VI1PR05MB3197.eurprd05.prod.outlook.com (2603:10a6:802:1e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 15:02:43 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 15:02:43 +0000
X-Gm-Message-State: AGi0Pua2Woas8iaQqvpmTEO+VJLyhEl+EQv2BcP5/D2g5fZ0njoAzNE5
        r/CakPEF4MrJncFXG8BfFXBcagUP7NW6NOR2H4Q=
X-Google-Smtp-Source: APiQypJecAGSzh6EfVMbgGC7Y20UIVAsV7RXFyihwphTgBjyxSXKRhk249Ab4SbtSokg3ekIHhX2jUhq74sTTTwY1kE=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr2526844qvx.75.1586271329677;
 Tue, 07 Apr 2020 07:55:29 -0700 (PDT)
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
 <20200405192246.3741784-3-oleksandr.suvorov@toradex.com> <20200407061646.pcglaw43kfmrag6a@pengutronix.de>
 <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com> <20200407111842.hp7mhrlsuesa74ep@pengutronix.de>
In-Reply-To: <20200407111842.hp7mhrlsuesa74ep@pengutronix.de>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Tue, 7 Apr 2020 17:55:18 +0300
X-Gmail-Original-Message-ID: <CAGgjyvEP8q9AmXr5nnHiw6zEhoTwFNOW4=wP8eeALfsxtj7L-g@mail.gmail.com>
Message-ID: <CAGgjyvEP8q9AmXr5nnHiw6zEhoTwFNOW4=wP8eeALfsxtj7L-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-pg1-f179.google.com (209.85.215.179) by MWHPR13CA0025.namprd13.prod.outlook.com (2603:10b6:300:95::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.5 via Frontend Transport; Tue, 7 Apr 2020 15:02:42 +0000
Received: by mail-pg1-f179.google.com with SMTP id m17so1852860pgj.5;        Tue, 07 Apr 2020 08:02:42 -0700 (PDT)
X-Gm-Message-State: AGi0Pua2Woas8iaQqvpmTEO+VJLyhEl+EQv2BcP5/D2g5fZ0njoAzNE5
        r/CakPEF4MrJncFXG8BfFXBcagUP7NW6NOR2H4Q=
X-Google-Smtp-Source: APiQypJecAGSzh6EfVMbgGC7Y20UIVAsV7RXFyihwphTgBjyxSXKRhk249Ab4SbtSokg3ekIHhX2jUhq74sTTTwY1kE=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr2526844qvx.75.1586271329677;
 Tue, 07 Apr 2020 07:55:29 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvEP8q9AmXr5nnHiw6zEhoTwFNOW4=wP8eeALfsxtj7L-g@mail.gmail.com>
X-Originating-IP: [209.85.215.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d617f09e-eb50-4b32-09e0-08d7db04b927
X-MS-TrafficTypeDiagnostic: VI1PR05MB3197:
X-Microsoft-Antispam-PRVS: <VI1PR05MB319799A1BCD75094045343ABF9C30@VI1PR05MB3197.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB3279.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(39850400004)(376002)(316002)(478600001)(81156014)(52116002)(42186006)(5660300002)(186003)(55446002)(8676002)(26005)(9686003)(2906002)(86362001)(81166006)(966005)(44832011)(54906003)(55236004)(66556008)(66946007)(53546011)(450100002)(6862004)(4326008)(66476007)(8936002)(6666004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J87O5YKbc/Uu15/8JJDoH0tCcA6WBGlYqbUdZitaGotre1kWO5SUbkeirn1aca7nsvg6NJIyJJ1yJd8ciGk5oVnGXqfkj8g8c43IYGkCS/93AIUCE51EJOmAABeCNjAKVA2rO1GVwF59g4pFmiSeUpPJ1PHp+nqN5yZ74KOD4K7cclAfOvcxpXKbG6q1nj+yZdgJ0SCJGH1Mkzgd3LTzNojEyOD2/TMqCnBqsvbMyOpdWWarBzjeJ9SV/EcAVxyvSGETJh8EtZ7UQn5BynmkQq3senyB9tpEPkkojsOAf1XHVHbxRucIi2k/z6EGQnjWB4rHVnQ0jS3vj3AZURKDsh1n9tEUAApDVQyNLd6J2PdZ5XSW3pu4acsdwVSn0DaJaE/AcgD+M5VRUhhMoSksQAJJLx99vvcjIs0E3p9RDbdukUO3TZUDe2vUhgDUhCQZWdbCEz7yRAA1yAa7OYOyFUwMXNifA7puGCLsLkVutH+aY/+BvVs37RqEazoTvCUesCaJ7nZ1cPhFiolXQepaJA==
X-MS-Exchange-AntiSpam-MessageData: yCnjryy0mQRGQcbswCCozBY6FK5qzrhclWe5Bjb6vRLgU2fmvpTGZC6p2AVrjgdzRSM6h6Wvrv+f9Lxttxc8vaT5IqjAcSSFoTQfpIvVnptBt3C5Wxk6lEEs24E1je+RijiiSuQWfQtvN0tKYdzKGQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d617f09e-eb50-4b32-09e0-08d7db04b927
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 15:02:42.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpJ7TC0OhxvwrC/oa40wq71iyPLobCejS+DFmnIBJxNW/DxHwkJSjS7cNY2z0JdPTscWyyM2iqWz+My+0qwIQppGhOJ+pkE1SyaLNp/lXzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3197
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 7, 2020 at 2:19 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Apr 07, 2020 at 01:51:42PM +0300, Oleksandr Suvorov wrote:
> > On Tue, Apr 7, 2020 at 9:17 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Sun, Apr 05, 2020 at 10:22:42PM +0300, Oleksandr Suvorov wrote:
> > > > Add the description of PWM_NOFLAGS flag property.
> > > >
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > >
> > > As I already wrote in reply to the v1 series I'd prefer a name for 0
> > > that explicitly handles normal polarity.
> >
> > Uwe, AFAIU, there is no flag that forces normal polarity, the normal po=
larity
> > is the default state if there is no flag to invert the polarity is set.
>
> Yes, that's the status quo.
>
> > '0' value in the bit flags cell really means there are no flags set
> > for the PWM instance.
>
> For me the relevance of giving 0 a name is mostly for human consumption.
> Currently there is only a single flag encoded in the number in question.
> But as soon as we add another, say PWM_AUTOSTART we have the following
> possible settings:
>
>         PWM_NOFLAGS
>         PWM_POLARITY_INVERTED
>         PWM_AUTOSTART
>         PWM_POLARITY_INVERTED | PWM_AUTOSTART
>
> Then for the first two a reader doesn't see if autostart is not in use
> because the dt author doesn't know this feature (e.g. because autostart
> is too new) or if they don't want autostart at all.
>
> If however we had PWM_POLARITY_NORMAL and PWM_NO_AUTOSTART to complement
> PWM_POLARITY_INVERTED and PWM_AUTOSTART

So using this approach, in theory, we'll have several flags that all
just equals to 0 (0 << 0, 0 << 1, 0 << 2 ...).
What if just describe default states for each flag in the DT documentation?

> every flag's setting could be explicit and if there is a device tree that=
 only has
>
>         PWM_POLARITY_NORMAL
>
> it would be obvious that nobody thought enough about autostarting to
> explicitly mention it.

If you insist on the flag complement model, I have another suggestion.
As the normal polarity is the default state, can we use PWM_NO_POLARITY_INV=
ERTED
instead of PWM_POLARITY_NORMAL?
It gives us 2 benefits:
1. The name will not interfere with enum PWM_POLARITY_NORMAL in <linux/pmw.=
h>
2. Each flag complement will be made with the same scheme:
PWM_flagA -> PWM_NO_flagA...

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

--
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
