Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C2172F83
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 04:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgB1Dma (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 22:42:30 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:6072
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730808AbgB1Dma (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 27 Feb 2020 22:42:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcx/fGpRAEbzOSuK3baAITgnXqJKNC+XFcJYp6FwgTwq4cjNPkJu6tRNVA6JM+3Hqj0DDF6tEtCHqRXnu2fCNUkn6yRMLtvrrCZAaBr6yIucpURMt0MGA7hDvvBQ6ygNLVTL3+vMMRYcPaAZXO71+R7N6l4TnjawwoZyIFU3DoXnU0aVkw+pHiz+6TfhJEr59N4Xne4iLwCF3jwCSFs1lf4+bld8FF0csTBnmsUxU9P5O5y943GHpuAM4atWQP5zhD2BUTxaYDB8BjcdENzzAO/nnVxiZBhHHTl5kp4rnI+ssButYuddtVdwwgo+NMoGxY11EbvMFdQ5DdlhQZCjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBzUoj7KxIhXm490ckzoyhq3smb8urW8Emzs/Gj91jw=;
 b=QY9wK3/BnPgUoS+j4EXkWK32TQ1HiwaKp2u9ec4Z2BcRSh4Mx2cjTHptYNtlHfM4mUEQERbaG6mZT0rwXvqMOR93O8Z+6KPcy+dUuFlB12k2zMw/u9ufbtVuUMK/+GE9I7oz/ThhoS15DbN82ApVofIKMrUpppUZbgqc9P0yYrwrxUHt/0GtYFvEZNJuRtA2jF0MECY1u0Eos+tHj5dmbZOeEngbS0AOkgzaWxCuFnz9rMTe9JXfMY7Q4XqJsiIKpZrps7c/ZnyjpDHtS5YOdQGTbz0dKWHtTd+pxepscKR7soiH5PBf2Hv4QrFp0XgD//iogM8rN+iF5WoATX7j/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBzUoj7KxIhXm490ckzoyhq3smb8urW8Emzs/Gj91jw=;
 b=CBp2RW16804OANk3+olgmPb4xM0WrqSUcjeZ2jLNq1dvfKVYGs9KzVTSOYp/Xb3+QMWt71nyAE7X5iuFOEetyoctgSlosE5GDX2axtsKtj3lAvMFHEybWVSGk9FpmH4MCazVs4W3U0l+vpMCbOGczZVYO59iQds9AStKbjXupgk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4895.namprd08.prod.outlook.com (2603:10b6:805:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Fri, 28 Feb
 2020 03:42:26 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68%6]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 03:42:26 +0000
Date:   Thu, 27 Feb 2020 21:42:20 -0600
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
Message-ID: <20200228034220.GA3510@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224111448.GS3494@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20)
 To SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 03:42:25 +0000
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 087ac658-452d-4213-3a1e-08d7bc003a98
X-MS-TrafficTypeDiagnostic: SN6PR08MB4895:
X-Microsoft-Antispam-PRVS: <SN6PR08MB48953C62C8B25B06B7AFA235D3E80@SN6PR08MB4895.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39830400003)(136003)(376002)(199004)(189003)(26005)(6916009)(33656002)(2906002)(186003)(2616005)(8676002)(956004)(16526019)(508600001)(1076003)(4744005)(7416002)(86362001)(36756003)(55016002)(7696005)(4326008)(52116002)(316002)(8936002)(8886007)(81156014)(66556008)(81166006)(66476007)(66946007)(5660300002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4895;H:SN6PR08MB5517.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLNyOAz44igADOsc3jVY9CnMi6qYma0/mSYfCmfJMsjLKA43sK5A1HVog1QgeLrwWDBZsAB1+rd7RbYmGrr5AYYnKk7msVtQgWJ7kH7iVLS8SrUfTk1FXEIM6csRW4/MerWuNgDQAfGflD4R6DgZlPnKYnzttOJx1ZqGVhpplMjm+JLllja40tKToZH9ObB3K7KCNjD6r32QgFPSEMPHBSq6l/eMqjVuPTAEdp8ONYZ4Q5PKLg2qcFV1IUpzJyAx2JwVJm03RJLzYQDtEPaI+mAa/XDKQ5fR6HzDBbCr+iuhlViGOOHoSfKmOBVFVCa7CfTdw6iJ4NdBIxgE9XfqpV7FpkFYsIxNJygcKcY03Ih+lX1Np49QUUn61/v3fUq6SvnuLTcLU6asB39vDYa1wnDkdgfBMi0bvkfzuXfD1+fQQ1LCheT4ScTEAKmZ409/
X-MS-Exchange-AntiSpam-MessageData: pKeFwkO2bfQ8EVT8ZV9p2JGlrXR0lLEpq1SJBiUEG/t1BPiv+6tF5iNp0veygwFEt3qW1p/noSakckDDDwPymTVNx1fuA99pfyzKljZdFEfawXDV/zXqXnrxzLpmNiBlgjajfhc+rOh+za0ISpnEGw==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087ac658-452d-4213-3a1e-08d7bc003a98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 03:42:26.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVqwKsgbuoPTirhdxX6wQ/C2LXwtPECZ2jtXMfB4vCQFalGXuPyh943QCqErAiwTQvXWeQJ2tpla7Er7/IKyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4895
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee,

On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:

[...]

> 
> Well done Jeff.  Good job.
> 
> Applied, thanks.
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Thank you for your kind words as well as your support in fleshing out this
series.

Just to confirm, does your offer to take the remainder (once everything is
approved) through immutable branches still stand?

Hi Uwe and/or Thierry,

Please let me know if you have any additional input on patch [4/7], or you
feel it is suitable for your Ack at this stage.

Kind regards,
Jeff LaBundy
