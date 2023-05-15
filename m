Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD0702FA5
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbjEOOZh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbjEOOZg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 10:25:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B314FB;
        Mon, 15 May 2023 07:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFXsFnO24xudEotq7rnnDk8Kp2q07cksOjWr+pUn4NbXS0dTVw/kih4pmhPARSXiEJxh94aS8sPyv8cSJHfMEa77ZXzj37yGnQ2EGXf5TpTa4PbehuZFNej9hHU5yymeU1xD8evPYICg5blk1lzUtEbGthzN85G7g08Fs2/YWAh2VBED7T/2BEMLuE0bQfYWQA7Sbkhx9RgIJdgfEM9GhzN59egXWJSv/HZN3JjLYI8SvyCzr3RaXh5fYUuj+Zq+JwCy1vK+qufONdFbayWEAvo6k7wE5y5eLndz+aFafJ/bJ37qvjzJCLM67b1cWX0njv89lDBkkzkVIBTJW7/nug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ0rvZDOr6OoU/FnLbXVDzc18MVxswNAXEchXwJm0c4=;
 b=QTktz2Iop41WtyxJ+8kVWeEyIYvJLNUMNBS89ZBRiiubRN9du7UGr6oqEsLuct91nmZdDB3JkF+e325Q6rQ0eU/nV1bd2GiayRIed4t368TPDbd1elmMfAXjqXnAmyzXNjYrH87wJfI4B8bNgUaIqgRURjwVeCwXR7DW/RzSClGrCXhr71IlS/8emTxCZw6tjZOEzqeHZZHhkuosVmkqACKi5xgjcdcTcH0adOpm7Qgo9w41KupKudEp3YaL95Y9SCvD3C2ZQOqymIzpDDIHH0tzkpJGywFQBfiiX2tD6k8xuRU0JVwwBzkHEO8edE+1JKkkstPCj9Db3ZHL5xqc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ0rvZDOr6OoU/FnLbXVDzc18MVxswNAXEchXwJm0c4=;
 b=pp5iQ6YMpex/ksEtTlGYOdzBzmiaQpSVg3sgR0Y5RI5zgPezzMN4cgNs6DQ4Rg1vlsHNwfRdGBRcuU96IEG112AqJkfEJYyXSdkL1cYRaUj/r3p5iv7ZUxcQNu6icz+N/BTIbenJa6kI/KDXzHsMsEejjpKNznhr01CKnV4k71A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SN4PR0801MB7744.namprd08.prod.outlook.com
 (2603:10b6:806:203::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:25:32 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:25:32 +0000
Date:   Mon, 15 May 2023 09:25:28 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Traut Manuel LCPF-CH <Manuel.Traut@mt.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: AW: EXTERNAL - [PATCH] Input: pwm-beeper - Support volume
 setting via sysfs
Message-ID: <ZGJA2M+V8ualidHH@nixie71>
References: <20230512185551.183049-1-marex@denx.de>
 <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
 <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de>
X-ClientProxiedBy: DM6PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::47) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SN4PR0801MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f811ca6-8505-47a0-a9f1-08db55503d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jo4Yurm7qAwQXBGOOZfM5gXyGvwDj4ufqYBki5m6RFs2RxLP1gaWxMgZwDxHfYv7+cGsiQ57hlNl68VIYm25K61HgRo4oADb8FsaUaCcD7dRfj8KJQ2tsbmaFX1TAEbmvR0OCizs4XA4oIMK+fengKvce+X/V05r109bIRFHGkGUtfeNfuq1T6wMhxmYIuybxRdRE9aMBaXjzeiGe2O9H7SjeK2kjUiyBLFV02B1OTamyfZr8qTFakr1uenKdWQdONp3LtPYuj1ig1Fu9O3vNzRs96SqZBzgw4pK1r8MmhRdy1Ptn0YKSw7ouWPrq2QhRO0Ohu9cpu3kRhORwRPVc0RAByVUwKCFufqe1J/TNnCckB2rpZU75kfRJma9lj4/rRq05wYuH6vWKzz2ZqMe/n77KrgQRUVQJsXSsGA+5xiPLimxYn+Am/O5DyCV2re+gDNHr66RTDSkWciSE68VVGdsp9GoFw/CPnX1nRsCpq/T1j9m02doj13yfijAlFtMOu18dK8o3K6NcdMIQopkS1AQ1Xxk5LY8mgWya3AJ4jI/q+W7v/vRy0qfj/hXMLl2gxRWvir1n0zO83gxU85WdM079bOwz+DG0/cq7L+dcRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(366004)(376002)(39830400003)(396003)(451199021)(54906003)(66899021)(478600001)(41300700001)(8676002)(8936002)(38100700002)(5660300002)(2906002)(316002)(4326008)(6916009)(66476007)(66946007)(66556008)(6506007)(6512007)(26005)(53546011)(9686003)(86362001)(186003)(33716001)(83380400001)(6486002)(966005)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V74BADbnwmvS9SFvDU6QGoWU7CYrWhJoC+ZJnqioaqZLg102yHOrYTs1GGSF?=
 =?us-ascii?Q?qtTk5N+U2MAJRDYV24WABK+1qd3aZHh8hA4GvVau7L7NP89NzoOpneSWpukU?=
 =?us-ascii?Q?ZFcOeo+2VJp3oYYJOj7Dc9ocRS7fQ7Qhv47LR2E95XC9X8CGiZ9rkvAm3qjN?=
 =?us-ascii?Q?333lDJ69G+PZpNXeruuaA2XNXqXIKaGpBGKHbteMdEDumbQZXl29Gcwjw+5z?=
 =?us-ascii?Q?rf+0TO/K5Df3K9IMpgLG6IJgl4DC3VboaUOJsA1qhPynOnwVwazxG113n1UU?=
 =?us-ascii?Q?MufwkTu+vav9Z3+s1rhN33ZPuwuND2j7CYgFJ/XfSsl169a5TZHlqdZCj7Yu?=
 =?us-ascii?Q?uRgjQj8RSkCJZxJSZnYp0NWWVsWqy+tgtcbDkthipzE9Tkw+Nwvp9EnFvPcr?=
 =?us-ascii?Q?POdkjgwzxeNWpRr767tgJuw9LeCQMZYH35i6tTjNEyH+nUq6xQ8PLx2L03x8?=
 =?us-ascii?Q?1sAM14xDWNDtyFNmZpGSl61+nGUwmzFdj9Or1+M7ctHcWWj+VVV7KKzQc2ph?=
 =?us-ascii?Q?QisZlY9Em9DTY8Bo2We7jZqCsqR618a0kpSNO/6PFOoGULHGhSEC18rYMz5z?=
 =?us-ascii?Q?EbMcMsuszYPdA0iQICho0DOe1Ef6XGbigjtlFrEDelNgD04vNTzs6R//tCf4?=
 =?us-ascii?Q?06qubJxZMuj5cODWpTDzxGUfo6tvjnHxJpawKk65NbHMu+sUK2fwEHa2cXO9?=
 =?us-ascii?Q?qs3n7gOB9TV6UKeopmJON6i0IT0DwLP/Ox8HMLiwFlCCLCteUA7MeBkpXLAP?=
 =?us-ascii?Q?lIxXG28QFwCd1F3tqPHTc2iaYC25iaNLUsNTNlJfhAg8/FV66oM2PpsC6efB?=
 =?us-ascii?Q?Y84Q28MrUv09wjnUtzLUg5nFMDL60Gai7hOIGloIDHoSKUidI9G+fS/+YPhj?=
 =?us-ascii?Q?kV2fEi40d+dWkm1wQOIOVxmJ9NGpgybJ7MAY/NtpfPQg6IyI0e/afJ5nHyox?=
 =?us-ascii?Q?yqT2LRNAuefR67t8ogyp19a/MZWkiS2+PQomEhXyaHc+gqLe2m/wrpqWn7Nx?=
 =?us-ascii?Q?CaEip1l4kQvFzK/xuOOilkT4jFuiPOLr26YAOpDXy9o5YKnyzZ1jdfnCbnGO?=
 =?us-ascii?Q?UuNHhh0DMaEiH1zUPA9lbQpNDP+zpb7H/MEOgCS64++P+emPBbWRKyER9QI4?=
 =?us-ascii?Q?E/jIg7Eu6WDdVUPo6mIYteLD1d03io90+hpjM0d9fpsPcAlXMRqYFg20rAR1?=
 =?us-ascii?Q?Sraieyzp6ilr09AHexomXkQh+522cICB2ncCnG80TJKBVodFcHaWA53SZKdr?=
 =?us-ascii?Q?yDKsS0If9YF/ERf6FdGZH0vMaX0eG3vLfBvCQHksz1PbcyZiLeIpkjuM1rw2?=
 =?us-ascii?Q?vzG2V5KoCAMbVeVcZvJYOCZTH6x43FrKeJ/oSbJPwNc8J0W1NwL15J0YfoXc?=
 =?us-ascii?Q?2Zujs0lCcVDwGX2ygLar+dRZ5qibcfCr0wTPwKMpX+FHuoXDlhImUkXXWKzz?=
 =?us-ascii?Q?YrbJMZfSBRgDkRTv+W1alknG0+cxAj20vj5a6Etn5qAf8+b32rwF5OoEqED/?=
 =?us-ascii?Q?6Cpi6u5LHH3hCYm7zb+tcTapSks41VaQNN12P0Fny1NbQ2zJYQRyj9jCkYbf?=
 =?us-ascii?Q?YAv2vyEwHZuB+2c9tny0DqCceXG7l9YQD2ho1LEZ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f811ca6-8505-47a0-a9f1-08db55503d43
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:25:31.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UwSAGPP8yOeGo7YQB0WGKRCL8OEbEUX3Dkccixcxqi9XBzcgyX3dWB+P1l8oIUcHXi9j/1BdSFCeJRds4Sv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7744
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Marek and Traut,

On Mon, May 15, 2023 at 03:36:02PM +0200, Marek Vasut wrote:
> On 5/15/23 08:50, Traut Manuel LCPF-CH wrote:
> > Hi Marek,
> 
> Hi,
> 
> > > The PWM beeper volume can be controlled by adjusting the PWM duty cycle, expose volume setting via sysfs, so users can make the beeper quieter.
> > > This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0 to 50% in 1/1000th of percent steps, this resolution should be sufficient.
> > > 
> > > The reason for 50000 cap on volume or PWM duty cycle is because duty cycle above 50% again reduces the loudness, the PWM wave form is inverted > wave form of the one for duty cycle below 50% and the beeper gets quieter the closer the setting is to 100% . Hence, 50% cap where the wave form yields the loudest result.
> > > 
> > >   Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > An alternative option would be to extend the userspace input ABI, e.g. by using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and bottom 16bit to encode the existing frequency in Hz . Since frequency in Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits just fine. Thoughts ?
> > 
> > I tend to not change existing user-space interfaces. I would prefer to have an additional event or using sysfs.
> 
> I am increasingly concerned about the race condition between change of
> volume (via sysfs) and frequency (via SND_TONE) . So I would be banking
> toward additional event, like SND_TONE_WITH_VOLUME or something along those
> lines.

This is just my $.02, but I don't see anything wrong with proposing an
_additive_ change to the ABI such as this. My only concern is that this
kind of change seems useful to any effect (e.g. SND_BEEP) and not limited
to only tones. Unless volume adjustment is less useful for those?

> 
> > > ---
> > > NOTE: This uses approach similar to [1], except it is much simpler.
> > >       [1] https://patchwork.kernel.org/project/linux-input/cover/20230201152128.614439-1-manuel.traut@mt.com/
> > 
> > This one is more complex, because the mapping between duty cycle and volume is not linear. Probably it depends also on the used beeper hardware which values are doing a significant change in volume. Therefore the patchset introduced a mapping between volume levels and duty cycle times in the device-tree to allow user-space applications to control the beeper volume hardware independently.
> 
> I wonder whether this mapping shouldn't be considered policy and left to
> userspace to deal with, instead of swamping the kernel or DT with it ?

I agree that the kernel need not try and linearize the values; in fact LEDs
already have the same problem. I still feel however that imposing a unique
maximum value (e.g. 50,000) is inappropriate because the range should remain
the same regardless of the underlying HW implementation (PWM, class A/B, etc.).

> 
> -- 
> Best regards,
> Marek Vasut

Kind regards,
Jeff LaBundy
