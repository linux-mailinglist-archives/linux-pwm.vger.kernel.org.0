Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F7175CA0
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCBOL2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 09:11:28 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:63328
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726878AbgCBOL2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Mar 2020 09:11:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjM9ZVQ2rczq42/GfY0qAR2kjbggkRnc2EgyZhGaCSyJuNVg/OKrHzHJwIll+tOgYdDUi62rkQez5SOuvQKc73QFxgJ9GL4cAI8LY/teVoT3u0jaSW+GqWdR1i4D6b+r8qz9uoRP5uZLagfiomtz3HVR12aWKpGalzNAefmCKQTK49oh36F7vLduKNPRRVvse0rpsljKad85rqGgzCHKpGm4/Fd4FjDbBhOSv3Ln2qLj2KPpciSNFIaZXCH+p9BYUMZ7bHxpcLcZdUEosiEBJQ35Vome3kABitKsANQyRIQ8kGORgLci0pI1GhvpUn81WpOJtG1HwY78MD5fVT/BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbLwmbKWK0AKi4bvZpZ0YhpSRFs5JeaU5JjGajCjhX8=;
 b=BLuKXxJK8kf/xcvPqYombC12TyuysMgKidMjDbBEMgEyekcKYNu1EQqT7sNL/yP6GiypKhBao+xz1CVEr+lYzl19hrj0ZPG/Lx9vqTyKJ2Z8c7le5gHZm0ZBNraghc8oSaQibjkBeQN+cxmHAotZRiWhUuoOpi9X41MlH0iphPqupeBeaCcZQgt6191T5f5vs88w5rmzLOZPZpgdHjuai8CByJLcSf7RPYH5HPm+4JvxMpJS0ZP8aDKIS9R2BzX7o2YWwM+RcJh63YIQlJEcO6WGODIFb76fUqPSAfPXZkuBwA3PDRWrwtwpu27P+pz50lKggKoQu+xJ50ItSWUmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbLwmbKWK0AKi4bvZpZ0YhpSRFs5JeaU5JjGajCjhX8=;
 b=abN+zdtW0YLXu96WYTm1gkxNtrn0PriqvPjIODvcWkUpAFZIQaGg7nMDm7xxv2iqVtvWFu3/4ce73Mw63+RbybFiPrwCyBXpIMaE1RekYWKO6w1L73cNqDiIQrFh9RPtDPC772Li8Dk70tAJM6KWjlf8ze7SDcVbNqmSen/4oLs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4989.namprd08.prod.outlook.com (2603:10b6:805:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 14:11:24 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 14:11:23 +0000
Date:   Mon, 2 Mar 2020 08:11:17 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200302141117.GA11787@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302120458.GY3494@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: DM6PR12CA0034.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::47) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 14:11:22 +0000
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b2b3b04-a9d0-4cda-e4eb-08d7beb396b5
X-MS-TrafficTypeDiagnostic: SN6PR08MB4989:
X-Microsoft-Antispam-PRVS: <SN6PR08MB49894BE86F9C92882983CE27D3E70@SN6PR08MB4989.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39830400003)(366004)(376002)(199004)(189003)(7696005)(52116002)(8936002)(81166006)(81156014)(4744005)(8676002)(4326008)(1076003)(5660300002)(6916009)(316002)(2906002)(6666004)(7416002)(2616005)(956004)(36756003)(55016002)(66946007)(16526019)(26005)(66476007)(186003)(508600001)(86362001)(33656002)(8886007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4989;H:SN6PR08MB5517.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CoKbVXtOpud5KxOeAjrDNL6TM/7xDlVmv2ToLeHB2eus9MTBthFGrzPLCZ/CQPiA4vrBYVlCP2qFz0ABdx9LK7x4x6tjpf88cKFetB978FdElBjywRMZEeJ7KouFVqC4YieaSbxmEIkYOJ3w59SFyigHzoUcZPxeDZlUi1/WOL+KRUdLxbA4ZI9zbSpKTFWBt8OPfsaRnKbiTcF01WZUlDWYN/XpFtA1BsO65LgjKPP/wW4ImVBgPFeF893EUg6ryaeZgJRVM22WjI+7O4bXRauv6QSHeuQV7e6q9m74gQH9RegXgoVwRgOSGdJd0rkROh6Cb27D3REA9SX3yXdS4f+xzb7j3oCtT06G8+ZiFDmimbYqylSPYDEUnAv5ZHwjZOR4o5TAYBMUGsILOLuHa8PnLWqlpl1GTaHoO44khaLThm9ugW1X6Dif59pYysB
X-MS-Exchange-AntiSpam-MessageData: z3RhbD9+9l69S5d4mQrrliAwPrnnqliHIP5KBkyRXBCpOmVkvAbFV1rWRuYb/jLOSBUWSnRBAdQ09d+8GL4XTyFIo3CoZoB9vTEfeFGZ5wPwGINbAW31BiraVUc16HvNL11r3GFAwjDfkkqZ+OyLXg==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2b3b04-a9d0-4cda-e4eb-08d7beb396b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 14:11:23.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tideyJCjx1EH903CoFmQFJPVXSbfqftmD9E+lHT24SbP6k/JmIM8nUXbMW3Ckpfqt3iC3an8/mqb+9iE8kkd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4989
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee,

On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> 
> > Hi Lee,
> > 
> > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > 
> > [...]
> > 
> > > 
> > > Well done Jeff.  Good job.
> > > 
> > > Applied, thanks.
> > > 
> > 
> > Thank you for your kind words as well as your support in fleshing out this
> > series.
> > 
> > Just to confirm, does your offer to take the remainder (once everything is
> > approved) through immutable branches still stand?
> 
> Depends how quickly you can get the other drivers turned around.

With Uwe's approval from Friday, all five drivers are complete. Dmitry and
Jonathan's approvals were given in previous review cycles and were carried
forward with their permission. If anything else is required, please let me
know.

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Kind regards,
Jeff LaBundy
