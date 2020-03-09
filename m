Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7317D75C
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 01:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCIAmW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Mar 2020 20:42:22 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:64128
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbgCIAmV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Mar 2020 20:42:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcShugAM+w0AkKqPKIa7IyJ+7KTPx7+Dnf2sZFsk3jDXke2pLlnxMJ/G20ZYqUQ3T2reBsWFMP2o/PSqnSZvUyKSZbKg8zIxSchc9bvkFdaZmZKTpZ9HtqWq3zKbc/F5wlUAQaSfxbYPkanKn6tNgOioLAhb3SfVskQDFP85nrFWaTMbclMwyguzDUgECzJw5sGMjK6z0iUDLwYgkoVtTlM3p5VLy6fIogRsgjRq7sVoQbWNIgPkqtv2lY3IngFgwEAwSIbV++P3zo6TAcHViqof3n6wmsSzdjVYs+tpqLqL/xF53/PMJ9zMvzF4nmZw5YIY5o+NLjbRBnTiwPM6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxNKXv51wD7zn8UvoreijsBGeV+QUr1cf8Fgv48vzE0=;
 b=cY/S0MpRcVJ1nmTMyQBOKlXi24qODfuBqU5wE+/AdN73WNGKECmD2sGfklLOeZkdMqVlEkyOtQW4b3tiYxVMLFsigPrYLmrd1Rm9c2W6C8DSBf1YY6ByV8f4UxfsLYyj+Yix8l0tUFz+7yPprMxE8a1LpXKAqiHdinvWGz1XHfzBCM39oUgmpHA4r+loyBsA4toMvs2iNTpDF3nyVNyCOUUIlVpKEhWFXZzfLc/oxMqVMwWsEH6W0sfurfMCEXSxYeut9dCbkt2p7Ss48qrDAERGV0MoINKscAptJC4DJADxJpHrqVbwBr1pubQH86aWyKAEIn6Xv9NP/mmwjt+6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxNKXv51wD7zn8UvoreijsBGeV+QUr1cf8Fgv48vzE0=;
 b=t4OKXi6vJlnIfRh/JhA4wVgizuLFFSUVjiF1qmMVr+NfHlQWj6ZkfelB4RNySAEXWrHgoovtVB/tnm6/8kB/TBoNexPSl1BZEC0LIWQFaUR7Y73VTpjpFmgiifnSSoEGIEio5XMPyw1SRn4vhM4ympOCHYRa4ycw6v1c6vQ5Cxg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB6064.namprd08.prod.outlook.com (2603:10b6:805:fc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 00:42:18 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 00:42:18 +0000
Date:   Sun, 8 Mar 2020 19:42:05 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200309004205.GA2684@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-5-git-send-email-jeff@labundy.com>
 <20200228092234.owlqvpuwu4hk3vog@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228092234.owlqvpuwu4hk3vog@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: DM5PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:3:7b::19) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:3:7b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.6 via Frontend Transport; Mon, 9 Mar 2020 00:42:16 +0000
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c00889-173e-4928-d62d-08d7c3c2b822
X-MS-TrafficTypeDiagnostic: SN6PR08MB6064:
X-Microsoft-Antispam-PRVS: <SN6PR08MB60649FED95746A9DF52DCC8FD3FE0@SN6PR08MB6064.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39830400003)(396003)(136003)(189003)(199004)(55016002)(86362001)(81166006)(81156014)(508600001)(8936002)(8886007)(6916009)(186003)(316002)(36756003)(16526019)(33656002)(26005)(52116002)(5660300002)(7696005)(4326008)(66946007)(6666004)(4744005)(2616005)(966005)(956004)(2906002)(8676002)(66476007)(7416002)(1076003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB6064;H:SN6PR08MB5517.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ER3L6+1zXOQbJgbHesnp2GK81SRIdzSVg+y7HARIn3I9QZIm/CFABwdRFotPsAf7bKbye+YITInjN947qr+EMxsTfzNX/W/vipdnipbApiQwAIpXv7Qwz7Y/4j4X40YBZ176LjdEq8Fy9BN0DlAJnaTP5IV2nMprTg0v8qx9GEq3e1zSh+n44k5C8pBH0vTw5PhJfnASp2qjc3SE+WqSRj0GQEzP4c9o24mXAiNXlabmhh2D0kAmmdyiDPEd5x+5x0d7OaLkzcJLwNvG+r+Vlw02KLyEFXrgBNs91Tk3CPDiuey9K5EGUQU4KEujtV2VwRPfRl4s0KS8fS7fKd2iruTZZSa085lpFsXW/DiZQZeQQQ6IVJUnIGjAWQCqSu4aDnAghs8+Q2PSfG2BMY463CE68lVi58a+0duxR4UXBVneuGw6VaeXF0IXIxPwBgX4Am89zJVplclnsx6cvEBH/Hi3dGrfbGPG0u/ecb6p+d9FynTLLMnTi/3Czb6xVwqr4JP+2FGqggKdZ85ZKgw38g==
X-MS-Exchange-AntiSpam-MessageData: YUEDyUZQP7lo2PbfKqoaxvbJUOVcNbPfKY6ewpXAUAiEk+61dy6nVUqCa07X439QGWiqZRkePdTpiHNNn1kiYrUMA//ZdC/YyBJRSdVyNCwe575hzywRLal/624pFAQEhl5/IFzyRzpJ9P3pqwzbAw==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c00889-173e-4928-d62d-08d7c3c2b822
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 00:42:17.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPUIq4eUX3W4l/3dKmMK8qT9RUOBQ6jDgvQHKkfHNkXilNfDm1sUH01SCR63AWgYYQ7/FBuK9YPGURHn0pN2hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB6064
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

May I ask for your Ack as well, so that this patch can go through MFD
along with the remainder of the series?

Hi Uwe,

On Fri, Feb 28, 2020 at 10:22:34AM +0100, Uwe Kleine-König wrote:
> Hello Jeff,
> 
> On Sun, Feb 16, 2020 at 05:32:08PM -0600, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620A, capable of generating
> > a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> 
> I like it,
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thank you very much for your steadfast support during the development
of this patch over the last few months.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Kind regards,
Jeff LaBundy
