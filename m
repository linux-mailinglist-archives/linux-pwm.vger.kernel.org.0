Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE6189B23
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 12:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCRLsB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 07:48:01 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com ([40.107.20.124]:44416
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgCRLsB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Mar 2020 07:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtzs2GW7vy0UmZRmF+m72Fpo4YleF9VH/w+g52Ued9FukFS2RmJIYi+MHnDyOFCD6ME27sKc8eaUUVLyC7IN2oGZ5qoe7h2rB7jMDulrsWTLEBmxthue2D4qazrjKxKq1zcDUVe5ETbIzhzYuiqEErj5K41VdaK2QpeV8qvCQMI9cMU7ovbPoAMHjNgsGCZ2h2gpT1da/kqWYWLCwv+MIaX7A/KKqV8yKpUqWlkBD6U7B1a8+cwk/zpxNPusCT+0D5KSumtr9IYJfFCTpUCsg4miBRyYx4vnHh+yq2n/1mxablP6G1eocVX25hLz/trvMgSQ5HTX85JS1z3/fcEzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP8agbcq2AYAILADyUgk5nJ/czwsxA8ATaSe+V6FyBs=;
 b=BNZiGUHM1VYccOLplqeqjFdv9LGeVzXOaJ5ZQN1tz80pYeWdJYqMP7lG0qAtXZmt6KoRcAGJQ81NNKdkQEYvnnPaOwzpQCRNz2b8pcSACK9uZZQArJQI/7XjBUr09SQrL7Wua9H676/tZTjNkj+oxqkvwhVhuJi+4tybgbITEYhCkXCCb/dX+kX2313Pkw15DD76S6E5pnDG378ETKXe6TmZGlTBrSU3/YPPHyXf4SAy55mQ/8cRWzjw/DLsDauowhOpP5FB/w5gUJrHecvclx764TRgM5oTBcOB+G4Jq4Nn8UFrBHHzAWFQFHQ6ezW5cvhSIGIxXcHQi5HchEi3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP8agbcq2AYAILADyUgk5nJ/czwsxA8ATaSe+V6FyBs=;
 b=raY6hGar69e12FrP/DIAVhCgnGos7uAR2lTW4uDkqcWc/mgg4e2cr3ZnjZXXAKaFGShfWzoVMH7P4dK2yxgyxSEOq9lF5sBH2+BgKOegmuEBACHawoTcAlCnIfXB/rZ2boE6fCJklSeCyPn8mOGKr1Y7N+grjcDUhLflPnZj+gM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB7086.eurprd05.prod.outlook.com (20.181.33.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Wed, 18 Mar 2020 11:47:58 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 11:47:57 +0000
X-Gm-Message-State: ANhLgQ2nindBXB5yIHNfw8a4SEU2HyslFZ9xg9azQBzMnWEnTFx1qhIG
        BojKT83PPo+dZpFKgGZh+Pf7B6/TOiulCqozTQk=
X-Google-Smtp-Source: ADFU+vuIN9vi3EnzahwoHqBu0uZg9qdX6KincFfsWht2IbWF+j4fV2L42M4aXtG7Pv38JtpTaFmsRwkNpHNmxW/8YWA=
X-Received: by 2002:a37:4fd4:: with SMTP id d203mr3613801qkb.249.1584532071685;
 Wed, 18 Mar 2020 04:47:51 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <20200317174043.GA1464607@ulmo>
In-Reply-To: <20200317174043.GA1464607@ulmo>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Wed, 18 Mar 2020 13:47:40 +0200
X-Gmail-Original-Message-ID: <CAGgjyvGDTD=ZgEjU540HLApQXCoM1a8bk_-eQbS44sge+GpeAg@mail.gmail.com>
Message-ID: <CAGgjyvGDTD=ZgEjU540HLApQXCoM1a8bk_-eQbS44sge+GpeAg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
X-ClientProxiedBy: MN2PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:c0::33) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qk1-f179.google.com (209.85.222.179) by MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend Transport; Wed, 18 Mar 2020 11:47:56 +0000
Received: by mail-qk1-f179.google.com with SMTP id h14so38096020qke.5;        Wed, 18 Mar 2020 04:47:56 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2nindBXB5yIHNfw8a4SEU2HyslFZ9xg9azQBzMnWEnTFx1qhIG
        BojKT83PPo+dZpFKgGZh+Pf7B6/TOiulCqozTQk=
X-Google-Smtp-Source: ADFU+vuIN9vi3EnzahwoHqBu0uZg9qdX6KincFfsWht2IbWF+j4fV2L42M4aXtG7Pv38JtpTaFmsRwkNpHNmxW/8YWA=
X-Received: by 2002:a37:4fd4:: with SMTP id
 d203mr3613801qkb.249.1584532071685; Wed, 18 Mar 2020 04:47:51 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvGDTD=ZgEjU540HLApQXCoM1a8bk_-eQbS44sge+GpeAg@mail.gmail.com>
X-Originating-IP: [209.85.222.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ff6e5f-e0a7-4632-8fd3-08d7cb3232fc
X-MS-TrafficTypeDiagnostic: VI1PR05MB7086:
X-Microsoft-Antispam-PRVS: <VI1PR05MB708653A6D05EA6C4D333DFEEF9F70@VI1PR05MB7086.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(199004)(6862004)(450100002)(42186006)(54906003)(186003)(53546011)(44832011)(4326008)(52116002)(26005)(2906002)(107886003)(66946007)(66476007)(8936002)(66556008)(478600001)(8676002)(81156014)(81166006)(6666004)(316002)(5660300002)(9686003)(55446002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB7086;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtWCVng/DCbjFv6x8LHcC+17QRXXijEQKLf43aO8yq0pHHt/+QfaZXU/+gVGgylOdUcgRAn1vqnRjOncD2Ji4Ae18qFw8PQuGyvYayUB+FfEh0W0fy46ZwYU1Ido/iI2JpauL4j2dQtzIR4wtxO1SN3YWW2W/ELC0z6WAIMBA8zC2wRCW7rMSrIjjb/nWbYXiofHlnqr663SDmhRHd6WriZSGRcFcmAHCIA2dwJCKOTKpIIBS+md6uRnnk9sKRxkkDpgt8u4fRWD2PgjnZ4/lmkxfwBwSwxPjkDuUt/GkqyeFBtF9k6ByUz3SH9kOwHtkiY82GrbT4+wXByzsMkxPFooVQeIkBUEFcyFqtQahKFgekT8akl0MYm895lDFCcaEiLAjhnwS6IouZW7mkAfdl0UorMmIGqFSm7CRAIUUgR1RYwJ/Ef/1y3tDrsWmpq+
X-MS-Exchange-AntiSpam-MessageData: yJyku39xAZnXhiEcq4BLI/0KPG1BsfxxQt94uADbYJ1seuNUTO/t8fkN3LY8dDaPdrzLSPjab57aiYy3hq0AgwH6yjbLAI9eSAykJtzG3+kl5hguFbmS3Tfnv96ebLLsrCUXTZsr+zXT7wmfic6TPw==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ff6e5f-e0a7-4632-8fd3-08d7cb3232fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 11:47:56.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ckb0Vx29Sh/fJO7GoM2lfyiS+DG7FhFtfv1o8gRwsdcm8AV/eTHHIpTAjmxRj3/7QjbWjKSBmxaW5kUcdKPDShtux4ufPp4+2gbrT3ejuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7086
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 7:41 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > Rename it to PWM_POLARITY_INVERTED.
>
> It isn't misspelled. "inversed" is a synonym for "inverted". Both
> spellings are correct.

> And as you noted in the cover letter, there's a conflict between the
> macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> in the wrong order you'll get a compile error.

This patch is a part of the patchset, which in result removes enum at all,
so there will be no definition conflict.

> The enum was named this way on purpose to make it separate from the
> definition for the DT bindings. Note that DT bindings are an ABI and can
> never change, whereas the enum pwm_polarity is part of a Linux internal
> API and doesn't have the same restrictions as an ABI.

AFAIU, DTS files are not a part of ABI.

I understand that enums are better than macros for some reasons.
However, I think it is dangerous to use duplicate definitions in
different places when values of these definitions use in the same
code.
So, given that the enum cannot be used in DT, I left only macros.

You personally wrote that the enum pwm_polarity can change, so the
desynchronization I quite possible.

> As far as I'm concerned this is completely unnecessary churn that's
> potentially going to come back and bite us, so I see no reason to accept
> this.


>
> Thierry
--
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
