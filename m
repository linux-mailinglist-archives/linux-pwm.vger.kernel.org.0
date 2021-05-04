Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF7372C6E
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhEDOwM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 10:52:12 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:38742
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230246AbhEDOwK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 10:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnNAY7uI1fF+ETnU204WTS+MONTblk9K2Vs5rmNEOy4umJ3x6IBD2j5gPCQd++vczy9xYodNBQi00/Ir01usAW+iW2QeVEr+6rg4wgZa5iL9EuRV87r7ebc0JWKSDB9witIQmzFQ5dChynLFqTiDNWzhH2l8RSRjxJabyMCH8Xpu9cDzul9/dnd5Xajp1NbdNIihOdZYgcqpy2KPFgT331HOzjPbu5k57nKRXfpS4B+Tek/cdl0iz1tY0nWBqTl9rNxJy72C6pdwgluohNaJwtP3hUiXKWyOxvZL3l17iHeEgKjfM4XziHHi/Vz0yjWYD4vL8uZGMmO0ad428yaFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VLI0QMWnt3yq1DZkZcCCO8qi7SPRDwDUumhibCC3QI=;
 b=FanOXTDPuwo5NgF6pwhUd2s8i26dbE76x0q8MRQOhoPANzzvto0alvfFD00qs52lyJx+EeNEzuljtPXuwJM9KmKkEAixqRUp9pOukzRY4fG7euxGDYCgkxbK72PhtnPHRHkpoOkzzZe7GdB4Q9DUT76cj3PoigmtIVWduLROpj76RDAOxrIvExFN7SgL9uliFp1OpWr+rnx4HJ/yLTXUpBccKxOyertT9pzyBzihmBzISQXkdKuk4qF7XTtDBIGVt/34SJdswj8lb5wsuNnOIdwwTF/Qn7f9UlAXOvgE2y0+iOEHuWy9QBjsBpzwaqF1GMzQMwbsetBb2J3t4jcUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VLI0QMWnt3yq1DZkZcCCO8qi7SPRDwDUumhibCC3QI=;
 b=s7QQ1uiZUFNqUKGWpc0Prj5aPQrCC1wUY7Nwt+LPjFVizd2Z67rzPS1N3nvlexXcnXz7HLaE8Y21GD7OEAR2fbHsHVs8x8+VaJsCJJfQHlfzezgfw6yp0eINxetsQDTnbtyokAoB20y+5dyzezzIjCU7MyBH01B1aw81N8Xfiqk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5368.eurprd03.prod.outlook.com (2603:10a6:10:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Tue, 4 May
 2021 14:51:14 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:51:14 +0000
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <1620087689.365270.2706594.nullmailer@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <cbb18e39-434b-0d67-12a9-6db943fe2bf5@seco.com>
Date:   Tue, 4 May 2021 10:51:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1620087689.365270.2706594.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 4 May 2021 14:51:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afc1b352-acf8-4d4c-3388-08d90f0c1060
X-MS-TrafficTypeDiagnostic: DBBPR03MB5368:
X-Microsoft-Antispam-PRVS: <DBBPR03MB53681E0E81EF25A9B72A663B965A9@DBBPR03MB5368.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUVWBumS2zyGCMTTCwrlYQsvbS03EQh6Un122uwyrmsd1w9lNat84a0uQaBFXDvLbJmduOUUXEDl8A1GGevQQFg1ZClyuTFYbwqVvWxbVHKFkbP0Bp9jWpLTjcuUmAn2W6LqcoNTF/KVQWx+1dCbBIIky/YgxkisiH+Bo0qst4BSij8KkKovRJRHnD82TX9jThdqSnLr3VKvjG9vYVawaBMfcqLiXMCrJD6qVWUnlzS7foGL1P1+o1M1a8xkYngR2eJPhGhjDdo3rm/tVgg8+13Ehp1wFV55SKYAorthmK4JQcO77KiG+dN1m3DMbZcDGECFHOnJo/hSChtoPRuo6czy/Z6bUuuwCsotpwOZDEu9zx5jaWMWZ23mEHAhdow5Nar96VKyGrYIrddHpL6LHuOAC7EYD+1lOyH94f4RIfEirhVED5vsjnYC6ODQX5Ioj7u9U1iWv16eZUpQm1F5USKGcvqhaGDgmcU3n78b/8dlomSJCGJCvRLnybSDcp9JXY4QNb5picgA6GgcFdxxdCALPhRk3QcG0tfcWA4wmeWT1JQxTNustSDxMaCS4zgNGI4/9JGn27RFLSnf8KNq3DY0DD0niZnmZn4L/RIgN3yfYbXQRaHCVqmvnocQ8dcityikYxeqZnkzsvjYpMM/3VsTK8uIEaXzkN0RN2k0oNNFg/j13iM0Ft5NDQYYTeezTH2OAgvqWLfws/mxyiN9wm0TM7HM4zeH9BOGVrFydyEMAPMmifRMkLS9dcCvherDTH9FcpcsRMmg6KpwnzwXxyg7xYV10uXnKR/FzS9UaiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39840400004)(376002)(136003)(396003)(36756003)(5660300002)(4326008)(6916009)(26005)(66476007)(53546011)(44832011)(66946007)(66556008)(2616005)(966005)(6486002)(478600001)(16526019)(52116002)(956004)(31686004)(316002)(86362001)(8676002)(31696002)(8936002)(83380400001)(16576012)(2906002)(38100700002)(38350700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NDF1N3ZSQlN3WU0zckQwTFM5Qm5td2RvSW5pRHhjdU1OVjhVR2RjL1hkajJC?=
 =?utf-8?B?enh5Zk8xOUlzNVl5TEpseEN2MUlHajJlbVhWQVk0ZVRqeGVYQnUybG9ab1NZ?=
 =?utf-8?B?R2NrNmUvRjNLeVVIVW41alFqZUVzWC9JTWpIYzJGbkRaMVNlRjNTNVc4cHBL?=
 =?utf-8?B?cHpOb1JOMHpEeWFLNGE0VU9XSWNQQnRBaWoxbHlGUWZyc0psdzlmYzkyYnhI?=
 =?utf-8?B?WUlMekFCZVpSZWlyT0ZOdDJxVVVUa2FCMnZsTDd3V2tuaFZZdW1hUDVwQTB5?=
 =?utf-8?B?Z2llZFhaNGdDV2hXcUdnVXQ5RE5mQUNrY1JnTkdNUU5yUWhaYzMvdTJEM2ZY?=
 =?utf-8?B?cm1iQ3h1bDhqK1ByM053cjNYeVNLWGkrTEp2aHZxNDI0TkIvNVRtb2VrN2VD?=
 =?utf-8?B?Zm9uVHF2b004UmxOT0RDdkFCakloYzdZUjZpdmdkRGJVWXNlUTZUV0tscHNR?=
 =?utf-8?B?S2ZUb2VXOFNML0lBeGRSa0QvYUVPN1dkMEtMYk9MSTJUTm1UcU8wdzY1MXl2?=
 =?utf-8?B?amJVY1VGbjNERXhXSHBjdXljVGVSOEVLTGd5Y3BXZzBkY01WSXYwR1ZUeG1q?=
 =?utf-8?B?QzdISnZpYlJIMnFMUENncGdaSkFtMnhDOU9JZkFVZnhPK0tmWkFkSy9IWjlM?=
 =?utf-8?B?WUlFb3dEVlBhaEd0Wno3WW84TDhseXlwQXlOZFlZR3RVZ0w3QURRa1pCcTJj?=
 =?utf-8?B?NVphNDlkcW9Kd1AwQzJTTzdUVCtBd2ZLR3lTZEYxeWJOc0lCbnNrMnBYM0lj?=
 =?utf-8?B?Z1NmemtwMVpEMFJVOWtSajBqWE11Z0huMmdXWlhGeUViaEpkcFZiT2ptMHFy?=
 =?utf-8?B?TFJKS281RFVSc1RQNzh4aGxXYWdCVk9UWGNwZ2tWd21VV0tBbHpqRm5yYWxM?=
 =?utf-8?B?QWNaUFBoTkFsdCtkUmM5eGc4MXo4Ukkwb1FleXBwSVQwb0h2MlFQVm83ZnBB?=
 =?utf-8?B?bkRyUlduSklVQUFEOWd6RTd2cUJFVnI1SEE1Qks3cDNXc1FVckdUTFBaeHBX?=
 =?utf-8?B?ZDczNTZWdENTdVVrTzhSQ0ZCVjZuQ1AyNS9ta0t3K0RPU245enVzM2xsSTFh?=
 =?utf-8?B?TkRRMnFwUVlOMmkyREJoQ09haW40Y0JjZE80Tk1LaHRkWlZlSXhtanluL3pt?=
 =?utf-8?B?QlF0QnkrWjZYVm9jaDlBRjN5a200VjZ2VzBMd3lKZk1GVURWUmk4d1lxYVhk?=
 =?utf-8?B?cWpXcHJ4K3Y5bWNhV3NPOWxUOVBReWkwOGg4WTRleUkvek1WOHViTEJaK0gr?=
 =?utf-8?B?ZVlHWlpYZUp0bTUwV0JnNWlmajNlODhRcmRENndlNWE4VGZ2RGhmQkl2dEVj?=
 =?utf-8?B?ZWpwdG12Wk1tcFVRRDNTNkxMdnp5eHd4a2xhS3hrYjVibXdOOWsyc3VtTE5w?=
 =?utf-8?B?eWd2aFJKQzNyMThxczlENGhOUU0vaTBZVXNzQ0M2YXpDVzdyTDExZFhvemxz?=
 =?utf-8?B?dkdDNTFtN1BNWXBsSkx3TGkvRGhLZnhCUHlrcU9xOXVNRkxGeVYwam9Zd2Fw?=
 =?utf-8?B?b2FFVEl4K09rOWx4WThnQUdUNGZhaENiOXB0R0VMYVJxMG9jOXJBNFIyTHFF?=
 =?utf-8?B?bDQzVG1SaGVzcFNRWXk2TDk2SDVNWTg4eEk2eUk2YU9IdzlqQ1pSd29tWGtv?=
 =?utf-8?B?YkVzcGJoWGJxbTlTZzFST0NwSHJHbjdWWmtYdDFqRVBOSjBxbzltWFM5L0hp?=
 =?utf-8?B?UmtVelloYXhTT1l3VzFmUXM5VmdCQlpHUWdKNnkycitqUk13RXdkRVYwdVpB?=
 =?utf-8?Q?ehiXhQV8W+mWk8byHgJ2B43OSnpMxNgLbmWL6yh?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc1b352-acf8-4d4c-3388-08d90f0c1060
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 14:51:13.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5dUbLg78UYqTNRmUZ4+I5TQRRJt1THwtPRaPQWcoZ6OtLSc9i1umqdnQaZfYi9vBsZAD5jVnrDxQecx5ek/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5368
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/3/21 8:21 PM, Rob Herring wrote:
 > On Mon, 03 May 2021 17:44:12 -0400, Sean Anderson wrote:
 >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >> a "soft" block, so it has many parameters which would not be
 >> configurable in most hardware. This binding is usually automatically
 >> generated by Xilinx's tools, so the names and values of properties
 >> must be kept as they are.
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >>
 >>   .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
 >>   1 file changed, 91 insertions(+)
 >>   create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>
 >
 > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
 > on your patch (DT_CHECKER_FLAGS is new in v5.13):
 >
 > yamllint warnings/errors:
 >
 > dtschema/dtc warnings/errors:
 > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.example.dt.yaml: example-0: timer@800e0000:reg:0: [0, 2148401152, 0, 65536] is too long
 > 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

What is the correct way to specify the 'reg' property? I see many
schemas doing what I did here which is 'reg: maxItems: 1'. Should I
instead use 'reg: true'?

--Sean

 >
 > See https://patchwork.ozlabs.org/patch/1473421
 >
 > This check can fail if there are any dependencies. The base for a patch
 > series is generally the most recent rc1.
 >
 > If you already ran 'make dt_binding_check' and didn't see the above
 > error(s), then make sure 'yamllint' is installed and dt-schema is up to
 > date:
 >
 > pip3 install dtschema --upgrade
 >
 > Please check and re-submit.
 >
