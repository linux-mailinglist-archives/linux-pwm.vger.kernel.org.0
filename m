Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4120918EDE7
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 03:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCWCQR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Mar 2020 22:16:17 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:3680
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgCWCQR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Mar 2020 22:16:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCSFPRg4zyrl2/jHTgvQHsDbP+DQ6Ei+tMgu9edt859q8ZbEDSUQUJ4lomCmCVYWbYd4ofbQLUDu46U3zNiWsCEqRZXxlnjN+8KBMSa71N+7TOQV7MrhRQI1T54Bop1pCLhl2zWgqvIZIw4cBeI9+v/8irEVI4vrc2nNl3D7kcZ9G8/OH8h8W0LVjwFAk9P5O7BLWSjKG8h20ErrLHWdVgcYgrdY6T9QQ6qkI2rDPpoRJjTUixJR+HSHsZLOpwY9iqlNiELQ5R4ygSrGtEF+P0EJ4Aa3bhE/BqgBz7D45OLW1QtWvjVf30MVHBiuEiiO0q0wekTrYlj/a43yoLm6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbBvtZL/EKf7OWNdo/un9vRVM623L5JFkAzHqseC2YI=;
 b=hewXEJxWa0WhCfMaiQ7CDoGI+EfYWYCahHalZ5KUTZQ9HFCk18/8AsCot7hLFEWUAb7es0pSvZTHONBXSsaz76oeZg3uPTtPRRffgIhqgXA3q0mkOH+olquJiySPwR0ywlKNlc3SlJWSqAms2BcV45j8nvoTIlkQF7/w4jWtCKTZw836Bulmx/0CW8oi88lvGhrSG4RAql7QR7A1YHXNlkecC0EHuDV7nQiI9+CA0m63AmudivGIjE0G9kqYljYo2bgEl/a/SSXmIBGn9tUhXa1mFe/DjSglN1843yMzcAnN2dHXZ4KkAixNYduCBK1UeYdwXe/BehPHChllFMNeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbBvtZL/EKf7OWNdo/un9vRVM623L5JFkAzHqseC2YI=;
 b=lvm2skNHRL3yMgDBnrBYHnuGBlklIBq5SY076qBf48SS2AQXPr7aFuMV422Nhciclnr95SNcM4slSU6WFrrOFuGpOYEkfhuzZQseF3bvqG/50MsEiFV0aGhp2gPz2gzcfcK0UoXH8WYiW94DET+m9eaiNaL15k8wPBjQ3YdTY2g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB5120.namprd08.prod.outlook.com (2603:10b6:805:70::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 02:16:13 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::e87b:9b6:d4b8:af68%6]) with mapi id 15.20.2835.017; Mon, 23 Mar 2020
 02:16:12 +0000
Date:   Sun, 22 Mar 2020 21:16:05 -0500
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
Message-ID: <20200323021605.GA2731@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
 <20200302141117.GA11787@labundy.com>
 <20200302142405.GA3494@dell>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302142405.GA3494@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: DM6PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::15) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Mon, 23 Mar 2020 02:16:11 +0000
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9c19f7-95c1-471e-0c69-08d7ced02848
X-MS-TrafficTypeDiagnostic: SN6PR08MB5120:
X-Microsoft-Antispam-PRVS: <SN6PR08MB51204FA55EF6716EB2BC559AD3F00@SN6PR08MB5120.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39830400003)(366004)(136003)(199004)(6666004)(2616005)(186003)(508600001)(33656002)(956004)(16526019)(26005)(6916009)(1076003)(86362001)(7416002)(66476007)(66556008)(36756003)(66946007)(8886007)(55016002)(8936002)(81156014)(81166006)(316002)(5660300002)(2906002)(52116002)(7696005)(4326008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5120;H:SN6PR08MB5517.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lt6SJbb9FYxKSlN+rfNryuw8WC7AO5EvoNQJoH4kdf60PW2hUOff6+ETrcNNPYjYDb5dhqqDBfjnR0IC7WuX/tNhHnOm2RAqZoyXB83AopKq6Q8k+svk9+sy/71j/g1xM3Kcz0QnMU6SRjncwi+7/F4OpKreArZmt2wBFMwVTO7rtE8lgy52iueWJllWDPETsRaiDwxNrSK7lNJZlRgLwY4vPW+s0G+KUNbTBOcKRqn4PnpLeWDWTSJecsd0nnJE+ALb59d1QIT9AmXX9ntsTCMOjca4UgqyfXplQLpJVAIJPZ3AE0ZUjLmH8r+MWKbJ6k67xS/AFU8egJmsZsME9W9T/DO1hHzoC1XzjTV31vEoBHtQkaVJydKXxhaWO9iLkhu7cHn3QPvZT1KIgqnFbwUyFmit7BL/sx8nf447CSM4XU1tdBGJT7k16Mj+sQWV
X-MS-Exchange-AntiSpam-MessageData: K7+lIfuY9XeXy789g03ittDPyoWjwY3w2xi0WDd5AKLVlODIo9azgObGvibx/FRs7gpa5tyEmABTBM3/WlZTDZKcKHysY9PD5TXCcYG6www4r3fPQ9P996guUmvG3HHsReQ9GuRzWp1Hwfhox5nbGQ==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c19f7-95c1-471e-0c69-08d7ced02848
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 02:16:12.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUdrbTHpoc1jBFZ37Cqs7hGjUt/FaFuLEJF780t6r3J8pzx9EZ9qW2GJDQSYFrnPjVEOiYU7BCSQm2M1za1ImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5120
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee,

On Mon, Mar 02, 2020 at 02:24:05PM +0000, Lee Jones wrote:
> On Mon, 02 Mar 2020, Jeff LaBundy wrote:
> 
> > Hi Lee,
> > 
> > On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> > > On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> > > 
> > > > Hi Lee,
> > > > 
> > > > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > 
> > > > > Well done Jeff.  Good job.
> > > > > 
> > > > > Applied, thanks.
> > > > > 
> > > > 
> > > > Thank you for your kind words as well as your support in fleshing out this
> > > > series.
> > > > 
> > > > Just to confirm, does your offer to take the remainder (once everything is
> > > > approved) through immutable branches still stand?
> > > 
> > > Depends how quickly you can get the other drivers turned around.
> > 
> > With Uwe's approval from Friday, all five drivers are complete. Dmitry and
> > Jonathan's approvals were given in previous review cycles and were carried
> > forward with their permission. If anything else is required, please let me
> > know.
> 
> Does Uwe's review mean that Thierry's is not required?

Sorry about that; I was jumping the gun (thank you Uwe for clarifying).
The pwm patch still needs an Ack from Thierry before it can be applied.

I have not received any feedback from Thierry throughout this patch set,
and I'd like to unblock the remainder if possible. In case Thierry does
not respond by the time you elect to send your next pull request, would
you be willing to drop the pwm patch and take the input and iio patches
through your tree?

If so, I'll re-send the pwm patch on its own to Thierry during a future
cycle so that he can take it through his tree at his convenience.

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Kind regards,
Jeff LaBundy
