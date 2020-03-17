Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AD1188A99
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQQlB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 12:41:01 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:51215
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgCQQlB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 12:41:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrvvEqP2ygVb+Sd0YTwao/vWLbzJGQWL01F0VwUM1XQdNghGuIhfKBa6eXHje/eP6z1wsAP0E+MQox2YP4a//kQcATTduGfZzMYkUIhkyi+a3AX+4wV+vAB55VzXGb07bXFRemJ3eqhZk9Oqlfp+71NqVDmopUZbIvx6LFrk/okwpQ7JcxOTvijIrubpFmAtMkXdpQj/TXb6sftsBGP238c9Fn5ufR9d2UebaQCAPvm+VGyfnJ6MNNyjciPB94/YZcfejUrEaeD2VyYSbZ5bd1CB/t8l45rNy+4bTpLIrnRZY46r8C93Nr1x8cA6H3gqQbm/aCNTIRUHxd/JtSg+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm6ch8xR8b3H1sbgs0W8m2O59cJyjN8XfUoPDBtfv7w=;
 b=O4y0g0MRXbJl2AkAE17pnwznX25xU6lSF91G+rB4/JZmo40rDb/ObCBraJhzpCPiRPQSFVpsCjLpsCNMh6pchdePBgJtl8d8jMNTDhaL11v0jsrmST/5xjWNhm6fpNC4qa6feovaBMJvY0FQqcXoFLNIgWeJJQiCjae7gekciOO02P1ZgAP+ZF4S5biFwLzSN7XRUQK/e3blQGUuLF9qko/YQOoL+55h44enn8fG66qAa/XzuVZg+9x5Ocz94SHvHDqhzUe/0m+Zwc9FQNIpovAt6ogwJ6Cu8hw61yp33g9rPNN39PdGtTW2h5lXMY1bIodBkU9RG+eR/3oJZm2VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm6ch8xR8b3H1sbgs0W8m2O59cJyjN8XfUoPDBtfv7w=;
 b=CZnXsEPPC1j7crjvgwSuh0B0u8sCzbMPoIlCRc7SuySkxI3zFW411zkDGg0kpneFRTEB9eBlzEAiD2MYVi1N3v+k9DiZX0eMDSFTWlkIN+eFLqeZ87dDjELcQC1ihdParMqlJ1frxB7h/ZBeo5FHLilUmy2nKh7fZ9gLjhQpKSI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB7101.eurprd05.prod.outlook.com (10.141.234.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 16:40:17 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 16:40:17 +0000
X-Gm-Message-State: ANhLgQ2UDUmCImpKz+G1wvx2PfnsmodoXgrbSmtRzzIAUloDLXZvK/ar
        5r8VjTqNFGhKTjojz4I9TXO6OUfATlOcsHiMwTc=
X-Google-Smtp-Source: ADFU+vs5IiH5xOxAVk1tazaO0nIxfpUiMfX+F2pIOjfJJXHSK1Aww98AZOBwwAUZz85BhDppVfRRsQImlnrWq2Voyv0=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr5577qvi.232.1584463209922;
 Tue, 17 Mar 2020 09:40:09 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <f281a6a0-a150-514d-ef02-4e51192031d7@microchip.com>
In-Reply-To: <f281a6a0-a150-514d-ef02-4e51192031d7@microchip.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Tue, 17 Mar 2020 18:39:58 +0200
X-Gmail-Original-Message-ID: <CAGgjyvE9+fHDKiua=BWBaTRGaChsOvnUnG6RGA9Q4V4uPuPEhQ@mail.gmail.com>
Message-ID: <CAGgjyvE9+fHDKiua=BWBaTRGaChsOvnUnG6RGA9Q4V4uPuPEhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
To:     Claudiu.Beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        alexandre.belloni@bootlin.com, wens@csie.org,
        Fabio Estevam <festevam@gmail.com>, f.fainelli@gmail.com,
        heiko@sntech.de, khilman@baylibre.com,
        Ludovic.Desroches@microchip.com, mripard@kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas.Ferre@microchip.com, palmer@dabbelt.com,
        paul@crapouillou.net, paul.walmsley@sifive.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        rjui@broadcom.com, Sascha Hauer <s.hauer@pengutronix.de>,
        sbranden@broadcom.com, Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux@prisktech.co.nz, bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:208:23b::18) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f52.google.com (209.85.219.52) by MN2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:208:23b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 16:40:14 +0000
Received: by mail-qv1-f52.google.com with SMTP id a10so11202300qvq.8;        Tue, 17 Mar 2020 09:40:14 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2UDUmCImpKz+G1wvx2PfnsmodoXgrbSmtRzzIAUloDLXZvK/ar
        5r8VjTqNFGhKTjojz4I9TXO6OUfATlOcsHiMwTc=
X-Google-Smtp-Source: ADFU+vs5IiH5xOxAVk1tazaO0nIxfpUiMfX+F2pIOjfJJXHSK1Aww98AZOBwwAUZz85BhDppVfRRsQImlnrWq2Voyv0=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr5577qvi.232.1584463209922;
 Tue, 17 Mar 2020 09:40:09 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvE9+fHDKiua=BWBaTRGaChsOvnUnG6RGA9Q4V4uPuPEhQ@mail.gmail.com>
X-Originating-IP: [209.85.219.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b32262c-ff35-40e3-18d5-08d7ca91de3a
X-MS-TrafficTypeDiagnostic: VI1PR05MB7101:
X-Microsoft-Antispam-PRVS: <VI1PR05MB71016734F68EB3F2E7B76F18F9F60@VI1PR05MB7101.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39850400004)(136003)(396003)(376002)(199004)(478600001)(5660300002)(54906003)(53546011)(55236004)(2906002)(186003)(8676002)(4326008)(9686003)(450100002)(34206002)(52116002)(66476007)(42186006)(81156014)(81166006)(66556008)(55446002)(8936002)(66946007)(316002)(26005)(4744005)(86362001)(6666004)(44832011)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB7101;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKonuMXz290BY/UAKJq1oktF/Sh42olr7dwIOB900dPUAE97wYMFkcwAE9hTksr6NQRTHE8f3Zq5pJsC7v2qu8JdSExxN0icQt3syG869ZU3WcXf7eZzZ6HIPTY057dIkrvlri4mCVbA8Rx2Rpt47O24bnkccUarL9/t1XI0ZsaWp1RecHqZcXUf5k62fKUYe+hYOmIFIGLNYIknunn/cqFEqceGoIXeQzNcJd1s+oscuOfToqYBsTpCcma4GsUJlhsezGsiHQz18jnBvDEk0+1lG0+edflK+bhtGNeUasHnhtyqcWRU9tqk8V3hrxjYfihedRaSPmTku9IkM4s3b0hHlMVM2dJI7aK7iWSvk1OBrQU+gNmbs8H4lMKql1bTFrVIF0XoGmIEJsubpt6c9nIUX4577bn+zzMZYQlS7ajsVWw1Ls4rvaCDBs1HUV8h
X-MS-Exchange-AntiSpam-MessageData: 06hGgKckLzQdv2qssAkipI6IqTjRAqBpLIi2NrVZCwnI6XJervvvaa1QlGtaSVX5IBPxlFC0Qfuo4LpnWt9K4wprIM0K2zP4Z7ql2PBmiTZnuwb+dcZvf4x1XzTaCSv4tOuDJUwSRvWciuIcO/vfNQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b32262c-ff35-40e3-18d5-08d7ca91de3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 16:40:14.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B8kwDZoLDKWVoyukFtVS0S9wg4dewXtpJCt932lxOvp9CGsc5t5HGAqMGocBpqDv3fywqT5lf6A9yzeE7grjvzI+glpaDy+pR1fBQlyciA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7101
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 6:27 PM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 17.03.2020 14:32, Oleksandr Suvorov wrote:
> > @@ -187,7 +187,7 @@ static ssize_t polarity_store(struct device *child,
> >         if (sysfs_streq(buf, "normal"))
> >                 polarity = PWM_POLARITY_NORMAL;
> >         else if (sysfs_streq(buf, "inversed"))
>
> You may also consider this string     ^

Thanks for the feedback, Claudiu.

I thought about it and decided not to change the ABI, as this change
can impact lots of user-land applications.
As a minimum, I can push this change as a separate patch to be able to
revert the change of ABI only.
What do you think?

> > -               polarity = PWM_POLARITY_INVERSED;
> > +               polarity = PWM_POLARITY_INVERTED;



-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
