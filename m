Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23FA18B3D5
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 14:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCSNDM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 09:03:12 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com ([40.107.1.94]:28933
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbgCSNDL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Mar 2020 09:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8JxkgFYn6ejoYvL14Bknc/3taLDqAPVhRnHqFM9+Add67LApRwjLGLZVcspMAEXkgc+m05fx3SA4TcZY6hXyz9oyPItDowa4LT1F97c1PuzgilIxLOEo0WZ4LwkIWXlI0wPmJwuTAY2MYSi+cppVXFGNvvn6VtRzzkwqFo2oV2gjLnnSe0Ce2anlbskLRVuJlq9Dw9ikoFdWD2QWV52QoK2Gp2qxEKbKcp+KR+EF+bhu7Y7J0BPd1uwsx+ropsVDqwFVdW72+KBxKQgMdz669qz53mtprrBPVk5vM4rFeVsRvJ8P8w1A6wLKkcU2KGcmnK424XyEU4FBf0787bzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct/vC+pyknaapJ/kjDeMGgchdOUlt5aZcJZO1q8mKtw=;
 b=WyWChx4rwOPq+eOV0RJC/SR68bWq2r6Ab4pChpN34R67Gp0RxQ98o64zmhFWBoUn700pQY3zXc9VRb+qsz1RP7790TJBoP4tnJoQ93Rpy85B4N0cMBbaXuJpoPyhQkyVPLRUN7bifax3oqZiZ3qewjY5dLkuMgIx2oEcHp5nkdlqu99BqgnE/BPgT3AdcN9BrhQOs1gVvQgzWmqIUSCRwv3vDAURwWUYTBq8bUtdMWEnB0NzusKMWbY071sWRaqsmijtDu+8W3IYKoazGD/YMO15U2hK3z4G0gb2O1eES1gcv0akURteq9bvgQEUnbJZQ0gLq4BjUwxuZdathXHKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct/vC+pyknaapJ/kjDeMGgchdOUlt5aZcJZO1q8mKtw=;
 b=tU0XZSw8e4Ws6iZOGfhACAY0qOFB6LptP/wiQNm3bDY4LOdL/QsmUpuSVGfc5wxLWtX2MZxhcdXBwQnXrZoOMtwYJFlToj4VF4qWVgsGTuEeMPTbAKCbRCLJ8Y1sIUEPxA5HEQeUUFZf0E3g777xw/ytCIkXIRggsMXi5DlPnqQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6189.eurprd05.prod.outlook.com (20.178.123.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 19 Mar 2020 13:03:06 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 13:03:06 +0000
X-Gm-Message-State: ANhLgQ0w7ngJPBJlFvOZsFY38uEFn9v1eGmnZjLsNEhxYSDJLnNpIZjH
        nMLOtsFkywVwXEWGRxGj1mlUyo1z80a65uxbUDY=
X-Google-Smtp-Source: ADFU+vv7UiYjMyQD/4E12h86CR7/cYPU2WKNtIqkeDfie1uanDVnCD4QjGal5pFHF/ZOfpjDVMav8J/uvLvFUH2D2Ko=
X-Received: by 2002:ac8:554a:: with SMTP id o10mr2778015qtr.224.1584622638973;
 Thu, 19 Mar 2020 05:57:18 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de> <20200318225953.GA2874972@ulmo>
 <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com> <20200319121026.3rzcxdknfyhtkryi@pengutronix.de>
In-Reply-To: <20200319121026.3rzcxdknfyhtkryi@pengutronix.de>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Thu, 19 Mar 2020 14:57:07 +0200
X-Gmail-Original-Message-ID: <CAGgjyvFebxXaKkhy-UR1-kaYWozpP67YtVf5mp4mTHFQRhsjKg@mail.gmail.com>
Message-ID: <CAGgjyvFebxXaKkhy-UR1-kaYWozpP67YtVf5mp4mTHFQRhsjKg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
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
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM3PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:0:57::32) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-io1-f44.google.com (209.85.166.44) by DM3PR12CA0088.namprd12.prod.outlook.com (2603:10b6:0:57::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Thu, 19 Mar 2020 13:03:06 +0000
Received: by mail-io1-f44.google.com with SMTP id c19so2135218ioo.6;        Thu, 19 Mar 2020 06:03:06 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0w7ngJPBJlFvOZsFY38uEFn9v1eGmnZjLsNEhxYSDJLnNpIZjH
        nMLOtsFkywVwXEWGRxGj1mlUyo1z80a65uxbUDY=
X-Google-Smtp-Source: ADFU+vv7UiYjMyQD/4E12h86CR7/cYPU2WKNtIqkeDfie1uanDVnCD4QjGal5pFHF/ZOfpjDVMav8J/uvLvFUH2D2Ko=
X-Received: by 2002:ac8:554a:: with SMTP id o10mr2778015qtr.224.1584622638973;
 Thu, 19 Mar 2020 05:57:18 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvFebxXaKkhy-UR1-kaYWozpP67YtVf5mp4mTHFQRhsjKg@mail.gmail.com>
X-Originating-IP: [209.85.166.44]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b21bc9d-2c8a-49fb-be61-08d7cc05ddb8
X-MS-TrafficTypeDiagnostic: VI1PR05MB6189:
X-Microsoft-Antispam-PRVS: <VI1PR05MB618992448139681499764DD5F9F40@VI1PR05MB6189.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(26005)(5660300002)(54906003)(44832011)(52116002)(2906002)(42186006)(498600001)(81166006)(81156014)(8676002)(55446002)(966005)(53546011)(86362001)(66476007)(8936002)(6862004)(107886003)(186003)(450100002)(66556008)(4326008)(9686003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6189;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0DJZn8OCp3LrljOxY0Gktju6cKZJFXe9un6szgTWEwcRydwt6haxnRNXvWZ67kRLwJKnJ9uS5YIdzW7cIAtdN+nSGE0NwgB0ZTIMHwiN2MljCDmCswjN8JsWrd5FC9Jx1YkRYuL7THh2S8njbqqstrFPtTlbCnpOE+29OHBMHApVsPdX5rDlzhV+MZ4ZAFnHPNB8sEO7F2wsCJeQEnCIguCqcGTjB2gccsRqoggCRNulVb59SXx6KZ7Ie8yNh30bTVVTlpN3vK1fh2kSQXZZm1WMFEJwkzcS4PULfXz/ORBuWPHpMm4sDDbc8Pv+9bacVeSBpYRIQGKCFBX1wnLhZFwpHLt5BCbIGjQWZZa0GXTaz1g2jIuhPc3P2lbJ8rPcuFuniAJPx7GThIPi6q9nvn8jKOkPhU+vrBjn6KvC91mpYLCExbOfE0U23ZU55V+tKZPJ6k+kp3r3FKHnPogBN81INHEqBYzbiPmjAxe6G4LXnnhMcVB60uPmIyX/MiLEto1L4PbHpR6677h4Pt+tA==
X-MS-Exchange-AntiSpam-MessageData: j2cE6DVaiBnQJlVcjGyGGW2MYrFyajBAo+7rG1kUA4dRI8GlyrzNUNWyI8MzXms/zTeiWRMQ2lmGXN88eB3wk3ClDDdBaKeiIjt90YlqgSoxFkGhqbb3iudK39/HVn98wjqDz21Tv0QV5Xx/aoywfw==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b21bc9d-2c8a-49fb-be61-08d7cc05ddb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 13:03:06.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN04Tsy9Rb3otdnYZo+UM9fwsaVcuJpiWK8Dl8WdIzZ0FVbvbsAyh6RRzv1ycqmk6cpbJn9LkZwMFSJj5FVtW+TpaVGxGZJ4edzeUJwfoPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6189
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 19, 2020 at 2:11 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> [dropping Tony Prisk <linux@prisktech.co.nz> from recipients]
>
> On Thu, Mar 19, 2020 at 01:40:28PM +0200, Oleksandr Suvorov wrote:
> > Thierry, I see the PWM core converts the bit field "third cell" into
> > the polarity variable.
> > Now I probably understand your sight and agree that we shouldn't give
> > the same names to bits in bitfield (dts) and values of a variable.
> >
> > But there are lots of useless "0" values of third cell of "pwms"
> > option in dts files.
> >
> > I see 2 ways now:
> > - just remove all "0" "third cell" from "pwms" options in dts files. I
> > see this "0" confuses some people.
>
> Then you have to overwrite pwm-cells of the provider. If there are two
> PWMs used from the same provider and only one is inverted this won't
> work. (Not entirely sure I understood your suggestion.) So I don't like
> this suggestion.

Good point, agree. But we still have the unnamed "0".

What about renaming the dt-bindings macro PWM_POLARITY_INVERTED
and add the new one for the normal polarity?
Like PWM_FLAG_POLARITY_NORMAL / PWM_FLAG_POLARITY_INVERTED or
DT_PWM_POLARITY_NORMAL / DT_PWM_POLARITY_INVERTED?

Using different prefix will prevent interfering names of enum and
macros in the future
and will allow using the named nop-flag PWM_FLAG_POLARITY_NORMAL in dts.

> And also in my eyes this isn't clearer, just more complicated to use.
>
> > - convert pwm_state.polarity into pwm_state.flags and use bitfield
> >   directly from dtb.
> >   It simplifies the parsing logic and makes adding new flags easier.
>
> *shrug*, I don't care much.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|



--=20
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
