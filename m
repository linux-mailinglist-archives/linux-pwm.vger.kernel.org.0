Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D4D1886DF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCQOHE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 10:07:04 -0400
Received: from mail-eopbgr130102.outbound.protection.outlook.com ([40.107.13.102]:3558
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbgCQOHD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 10:07:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE2bgz7rn8gHPPOPTVdbPFfRt4mODHsBm7EpgC75c7ZvXUgIsz9cXi8H8H5gs4sqce+7bOXoayu7YHF+UAXMlI/uXCDH2ipqxzIVYAprDJshNLnWmHF9rMsy/KN7KGDKysc5mEGg8kpABujWK0M1Iyhktgcj3W1ftz1kBGyrzjxFAsOn0qUA2rLabmV/VIzeGY9SgyG/yXntsZWONfo3c+HwWste6UbugRRxu6sy95e085zBPzy9rZtIeU3kc/MVo8ydNHGa/r5AvRCQKx5yg04zc+1NulI9/bSvAtfnQfhW+Xd5+4qKpLhxUUqdqw67xl2MZaz/va9uuxZ9pm+19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/xGujxTZSfW5dIi0EdPOrKPleR2KkmH3wJ9vCbaQOM=;
 b=UWDyCoK16GLHcjpUbZahebiTReHEVAoKCPDkT4Whf4EyGq/Xk2uVYyAepgFbQ0Uwfg738FuB32EOsp8xORx6a+iS1jsZyKLq+P92bylSkRGOuh/VXg3Fc1AtsdtQEasPmKcg+i8cHCN1lAhMyMXYjRgAwNAZdjWv3fQnmKWN6KpBsZHgpgmkauHDOPLl0YOHA+JeVv3enA15G6uK5eT9oArdPQQTmXgVYuhQuZ3jjU+VTPuXwUcpBCUMK73ez3HxM761S1WDQrs+fdTtYGuQIc0UZvgVobgJV//sl61PjuBB66gi0L5vs9kiSmXGynpXVerQdv4uaMM6IdK9Ehaw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/xGujxTZSfW5dIi0EdPOrKPleR2KkmH3wJ9vCbaQOM=;
 b=igLw0YmxI2z94kEKmOVQAOaPIk1tlzGr7nHGRqf5TqGCvTFeQFm08DGLNGLUx+gBK7eP9jjKlmqFOeiVmUvL4G+N/Zte/aAyvr+WVB4QI00V9CMhNfbkWta8qasmGoTTkwnc/polXi43pKCt5qgEiyufjc0I2d7ReWSNTaS6HQo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5248.eurprd05.prod.outlook.com (20.178.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 14:06:58 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 14:06:58 +0000
X-Gm-Message-State: ANhLgQ2Wbc7gCob7YPEWnkugt57VhzrcJlpBaYZRcZLkXg0h8AFrq4aM
        hV4yu+SvCwjAUvX10l2XJSk7MSSiclxxhzLrXoU=
X-Google-Smtp-Source: ADFU+vtbyeYQyb46ie2CgS0aFyVWyZTrX/BTxpkXAH+zu59c1knd9JgVb22NYfF7ZbPl/jveZxcnOUj+sUw2eoiafAk=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr5006940qvx.75.1584454013450;
 Tue, 17 Mar 2020 07:06:53 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-4-oleksandr.suvorov@toradex.com> <20200317133638.5951a743@ub1910>
In-Reply-To: <20200317133638.5951a743@ub1910>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Tue, 17 Mar 2020 16:06:42 +0200
X-Gmail-Original-Message-ID: <CAGgjyvEye0nEwyUpjTxVV2ftvF+QUibLBdiT3ZSsX6M4PQSW0g@mail.gmail.com>
Message-ID: <CAGgjyvEye0nEwyUpjTxVV2ftvF+QUibLBdiT3ZSsX6M4PQSW0g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
To:     Paul Barker <pbarker@konsulko.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f53.google.com (209.85.219.53) by MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 14:06:57 +0000
Received: by mail-qv1-f53.google.com with SMTP id c28so10869039qvb.10;        Tue, 17 Mar 2020 07:06:57 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2Wbc7gCob7YPEWnkugt57VhzrcJlpBaYZRcZLkXg0h8AFrq4aM
        hV4yu+SvCwjAUvX10l2XJSk7MSSiclxxhzLrXoU=
X-Google-Smtp-Source: ADFU+vtbyeYQyb46ie2CgS0aFyVWyZTrX/BTxpkXAH+zu59c1knd9JgVb22NYfF7ZbPl/jveZxcnOUj+sUw2eoiafAk=
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr5006940qvx.75.1584454013450;
 Tue, 17 Mar 2020 07:06:53 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvEye0nEwyUpjTxVV2ftvF+QUibLBdiT3ZSsX6M4PQSW0g@mail.gmail.com>
X-Originating-IP: [209.85.219.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80614da6-3774-4fcb-c940-08d7ca7c74a9
X-MS-TrafficTypeDiagnostic: VI1PR05MB5248:
X-Microsoft-Antispam-PRVS: <VI1PR05MB524876DDDF9792AB3CC775CCF9F60@VI1PR05MB5248.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39850400004)(396003)(376002)(366004)(199004)(66946007)(4744005)(316002)(5660300002)(8936002)(478600001)(66556008)(66476007)(450100002)(6862004)(4326008)(2906002)(9686003)(44832011)(26005)(186003)(55236004)(55446002)(86362001)(52116002)(8676002)(53546011)(54906003)(81166006)(81156014)(42186006)(6666004)(67856001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5248;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 804oMNWv7rXbuckoLdgJ8UY0pZeshQ0BkxWqfFsvNfxa6BKm3C8QM0p8N0/h8b7NYGS97DQ49rBRQrRadlVw598fIEkenQY3DOrdidva+Ypi6jl8rcX/L12Jj/lLBThfvW1ekEH8jdzX5zA6qzQE8fm/YD7fKp58MmZuwe6OLRhfY9SakFiONO1JH2dYeHZU2aniNcgSi9gsdWuCoWdD53pleT9jL/xJLQfKXdbgQfsvTvuI6AlFwQyGKY/T5W7N/tYj/iOgkJkG6BeueDya2eep4VxW0vuWhF0zqsJt9ITPvv/oibKuzdaUTWhBlPsiVIy6eqMpEw/PCYER4BlMHQ7Sxp0ZhgGI+JdPL5PDcbsi0s7nNaycfLBorCXK2y7PsP+kiYjwrPqRKCYVNONy9TYAGtVSs2Pd8SjrHGGeeu2G/gEuGYMC01N48qprURMSQDmh9Ignoy6YW7xnb2cBqOnKu/4nfbQb66B9sT0hHF4=
X-MS-Exchange-AntiSpam-MessageData: qtluxydKO65JRII/QPtcxCLSCo6feAkA6e1dAdsoxxg1CRzT3VBgK/4aNn9nRnaNN3Wt/Axs/lPw4Oqqq0ohru7WUJ+nmErEXNkL2PVhJYrPmfwbww7yzOvf6w+oFFqt9inS3ErNC/x8iwgfmGNT2w==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80614da6-3774-4fcb-c940-08d7ca7c74a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 14:06:57.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hozRJS1ZHHLFV7Wjm6UF7A6w88YPEjIWqGB+g5Clao6U7kAMh2qwXz/n+h9bed05mN2LStsOiIcsJx6Uppv/k8c/BIYVksGfWhixxHRf4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5248
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 3:37 PM Paul Barker <pbarker@konsulko.com> wrote:
>
> On Tue, 17 Mar 2020 14:32:27 +0200
> Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:
>
> > PWM can have a normal polarity and a reverted one. The reverted polarity
> > value is defined.
> > Define the PWM_POLARITY_NORMAL to be used further.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> s/reverted/inverted/

Thank you, Paul, for so fast review! I'll fix it in the next version
of the patchset.

>
> --
> Paul Barker
> Konsulko Group

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
