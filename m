Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7566031B3E5
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Feb 2021 02:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBOBU2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Feb 2021 20:20:28 -0500
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:23392
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229904AbhBOBU0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 14 Feb 2021 20:20:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/n7RTzQSIo7bMcL6WcOQvcIl5AeU9n8ireVGNkeeQzqXW93Po7hQeuxst54lUJn/KqvgzRaoIbi8G+AapIVCvdetE0/zfED+qNAJTzOn0u6DhK9nSzbU166hPGETCTCQEDVrroriovuDLnphfxm6OqgYe5xkcMSDew4hy0QmO6cBlBPsaUkg9H9gdD3OD/ECOUS1xPxKKd5ljNnqivk3jZWBQbhdnq+vIL/84ZLh52tkmZg6n38Wzj09ZZIVvkK/813JPZNqBkiXyTQAaZyX5+mGHrXwv7U8X5wFlpwBGJCicqfmq9jfkRWLMMXD2FZpN5IvJsJnQXXkcFXL/USCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80wesyPMEihKwQ+d9Rv4Jcid/myPTDWLE0OcMVUajSw=;
 b=H0CbM1C5aJcbFTJP288v6RZXuj7ZoiO54QUDEVR6YpYznAWJplNPuhXTnjN3XM5yigJkORLPB1/oeeB+wgzUDW8D+K7KorP7NmAIz3WsnVUEKdncgWjSkoTTotaenqdE8WO+PrUJA9wCzNCRjHQVPmhp4tSfDxffoCKkmHCGCQEHFmGpSOKWU2KVMGCmenMFP3AkLgIoumcwNAw9HoncFbSZqopbQvX/H3pHf1EVzRLvVU7MuLFjGJUWTa0d4/HtYe9dszztPuR9T6UbQu6mZiv76CWaM/Vds11V+IE/ga8kLJI6gl5Ylx5gpzehOJsTqnX8V0QpnUxVmnUD7uJfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80wesyPMEihKwQ+d9Rv4Jcid/myPTDWLE0OcMVUajSw=;
 b=RLAj5DxslwcG1Lghc9KBMy1h2quwGb0Vq/1RCHd8WqVOPrbMjx0y+5I7Ld3tXLK7QwcXVx6HtfZSOAGMbR0to7GGPSGd49+ZpFfx+JcZIvhNvcSoRbX2wrd1z/Z1gc4y5Q32iYigznRc1f8deBMdEHYYybxAGtpDMppYzNIzsfA=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7134.namprd08.prod.outlook.com (2603:10b6:806:1a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Mon, 15 Feb
 2021 01:19:33 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::79a3:8aa5:feb8:7f04]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::79a3:8aa5:feb8:7f04%7]) with mapi id 15.20.3846.034; Mon, 15 Feb 2021
 01:19:32 +0000
Date:   Sun, 14 Feb 2021 19:19:27 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210215011927.GA15385@labundy.com>
References: <1611030629-21746-1-git-send-email-jeff@labundy.com>
 <20210122181239.ut33bmzxlvy2mx5f@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210122181239.ut33bmzxlvy2mx5f@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN7PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:806:121::14) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.173.128) by SN7PR04CA0069.namprd04.prod.outlook.com (2603:10b6:806:121::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34 via Frontend Transport; Mon, 15 Feb 2021 01:19:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94bb85cf-bdd0-48a4-151e-08d8d14fbfcb
X-MS-TrafficTypeDiagnostic: SA1PR08MB7134:
X-Microsoft-Antispam-PRVS: <SA1PR08MB713446D575D5D5FA09CBAF30D3889@SA1PR08MB7134.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcVs1ujLUcx0KgaA96d24gTEAN1dTKgMrck5sNvXetJ44nUOs0BKTe37T+EtMiln7KOrQrC6Gd+SJGC7E5sd1SeZvMmqo4KgindV/nD/d+cZUJy0LhwMsXqtaUuG7D/woObCUrkoV2Qsapx2wVp7CsaywMfpxk8a8QjABLbR17o6XmeLDH5yexF+eefHqcsT9haCDFeHQfpQobbCyciDkDTfxTtPqmfWOAa7BBhMckjIsI5fTuqzrs+xpPdolnIdZwMu0gTuH7AC3HWQ+YrEgy36xG4WAutHd0DESiEiZMHuaou3MMrWwfplDB7NMSV8lw1Cc2Z+3rQJs0/9ZCkikCbpR+QmfMWcJKpIcy9MHOZ6q6GAqu235Q4shX8xMF4vP5Kwq0ZSaWYxZiRQPirphaIcFP2tqdRKP+4YINrt2qLJH2Z9HXOHITAqnLAfc75dNylmlsj+OT1/34ZDB+7rjYLbS2JF9+UxEe4Wimhoe0JWB3YlgUc2zLpjwZnGF2ZSnYH1i3uAvCvAxGp7n73VsQAKX+4Tc9RyTkcUOoPa2l1zFqz6UfYZAY+Z2bE9Zj9kjv9vIga66E6/vhW9V6lZYzRYCNYfyrghkLI2PC/NujF2RUPrxkBmwNlDSSH5oZEBVbEYtRNJyx2+9WHSqGUAxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39830400003)(478600001)(33656002)(36756003)(316002)(2906002)(8936002)(966005)(4326008)(66574015)(8886007)(8676002)(83080400002)(6916009)(83380400001)(86362001)(66556008)(55016002)(1076003)(66476007)(66946007)(7696005)(186003)(52116002)(2616005)(26005)(5660300002)(16526019)(956004)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?8psPlpujWfTGJcN2SZKsZvOtnVglrurJNxkoDx2aFOyJ0sUxcoBSY6iFFb?=
 =?iso-8859-1?Q?rOCwRdXeBxIBVBlCGw8anpSkytv+JKG5HEn51IeV8u+YHOuGJN/AxiNsIv?=
 =?iso-8859-1?Q?D+x2uwsLX/EFzb2cQJ7tH5IQ4eedky0cWWvVOUVvofq+BfdK31HOhrcBlP?=
 =?iso-8859-1?Q?T6RHMV6gTmf4dF92PsoLdDDvIM09/U5OTdnlNcFJjJip0hTFktxF+TJ6MR?=
 =?iso-8859-1?Q?UbONLXztANz2uV4MO2hzXKPKfqUB5GCBf5xJyfdHYndAMb4xIN/SkJjwB7?=
 =?iso-8859-1?Q?VUqnAQDjYXVKMoXd2s5Mu1/PUKmeL63veqVfmxEOg8dWs1aIQS5lly6wu7?=
 =?iso-8859-1?Q?MkR2r1J/gmYU58NSMujITHrfPnmD5mYePEk3hCWFhFKzxbZXqUfE99ZxQk?=
 =?iso-8859-1?Q?Sfrtkqe9quhF3jz+WJ70fWJCFZq1MldL1VtwnT+w9sreuVxCvB4T6Q/4N0?=
 =?iso-8859-1?Q?XH5RQCUD/70UoSwL8IeEzcBEWCNyTlmtMxhwTGd5jOvjs6HTtK10/+QCQd?=
 =?iso-8859-1?Q?VBxuZTIzgFaPARf6X59HtF8W+DzUNicFCykFqgpDLuB+XKPZEOarSIIkhB?=
 =?iso-8859-1?Q?0fj3nkmK0OA1YMKUayAC+XLlN2M8ai0VPddkqSTSkkYOfNCJWUCodnwgEe?=
 =?iso-8859-1?Q?muqu7TrhiOjOKkdeMmHsCeZqEz05xzJbrkla7RuUZWo3bAJ95oYv3wSUZO?=
 =?iso-8859-1?Q?NzCUb/wdNhfpwi+LrO47f2ktNCkyIRS813tAEWa774L20bVTMeHJ8NTxc/?=
 =?iso-8859-1?Q?+bUSz6YfIusdivFQL6ADLvsQj0gKGYzCbY5P4V/YetTB4zL5OncWcDGBB1?=
 =?iso-8859-1?Q?3Z9fF2pPVVRc6wWe7Py7ANw/8pW1cbjymhyLDEPinyLGKtMP3UuoD/rjJr?=
 =?iso-8859-1?Q?fkSCaEwaBopcnqKUljghHmGzKFSit9R3hVaZdXfpqUC/zucjpXt13ijSfp?=
 =?iso-8859-1?Q?lBZ2AbwGWLLeWPk/uMm7nuYiBJakLC5zl82+2123uamIjht0tyhbbhG0Np?=
 =?iso-8859-1?Q?0fTxn7K8idey6D6oLeZCTPNehonfjmxEWpqTDlhU0849lW915bGCWSEYV5?=
 =?iso-8859-1?Q?J+B1UoxD4mREedSjaltGNYDGguTD81vIgwGhYMD2+PNUW1T3vjDaYSEWU5?=
 =?iso-8859-1?Q?OEv8HWtHyM0S0VkRr+qSf9xzvofDStBtnoEQRIev1aB2p7n9QP+20Pcnu+?=
 =?iso-8859-1?Q?NZ8ZYQbpn61+cnMW1RQjFibYZm1+/DpIGvFZk7ulcjdf7IqCmEM6kjTMO9?=
 =?iso-8859-1?Q?H3GbaQuhQo+ECKa/htU9EyvyUlw3uF8orEf2nzfW46dHVlvI42vDrgfx3Y?=
 =?iso-8859-1?Q?w5AD+PuwANhghvoG2QLZDoR3Sd2dFmb7/DqiC8mTDlvzHFsZqpzVBH1Aul?=
 =?iso-8859-1?Q?aLykW+aWy5?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb85cf-bdd0-48a4-151e-08d8d14fbfcb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 01:19:32.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwsj0peEditHF1EXkzYXub7p0uPyggLv9/n+Q9BBAdXpvppXXDEAzeDPhWYQn8/yZ1d0Ti61JktpedKaNJ7lTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7134
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

Do you have any objection to applying Uwe's patch [1] followed by
this one so that they can land in 5.12?

Hi Uwe,

On Fri, Jan 22, 2021 at 07:12:39PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jan 18, 2021 at 10:30:29PM -0600, Jeff LaBundy wrote:
> > If duty cycle is first set to a value that is sufficiently high to
> > enable the output (e.g. 10000 ns) but then lowered to a value that
> > is quantized to zero (e.g. 1000 ns), the output is disabled as the
> > device cannot drive a constant zero (as expected).
> > 
> > However if the device is later re-initialized due to watchdog bite,
> > the output is re-enabled at the next-to-last duty cycle (10000 ns).
> > This is because the iqs620_pwm->out_en flag unconditionally tracks
> > state->enabled instead of what was actually written to the device.
> > 
> > To solve this problem, use one state variable that encodes all 257
> > states of the output (duty_scale) with 0 representing tri-state, 1
> > representing the minimum available duty cycle and 256 representing
> > 100% duty cycle.
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> >  1 file changed, 37 insertions(+), 51 deletions(-)
> 
> Nice cleanup, thanks for picking up this idea.

Thank you for your kind words as well as your assistance throughout
this and other patches.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Kind regards,
Jeff LaBundy
