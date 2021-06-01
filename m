Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923E139785A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFAQs4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 12:48:56 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:48198
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhFAQs4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Jun 2021 12:48:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7/1Us3JCYCyVET5BHr3DTNOsWtgtbGa8++YX3qZ7IMlWluKOyxbCKqM7mDx3qp2LJjBxoyfwPtKxrKYbUmRnUBneG04eU11AxsI6d/uCMqLfG8Gz3HHJuc7diQbpjw/mv83C40Wi94gmAx1tO+oZtPfTqhkqHpXddpfU868ROmLUgWxucBXmOZizunUqvmzvL21KL6YR6CcD6JPpvUdGuEEKx5ItDSRJEMiBJOP/0STiTMlWXz1BGT7ilG4gxvdkWOZsW+h7eU1QnUhNFQNPMNhYnFkux4XpsBlfRtxeEV8TN7hv1s1PBS0gbEbVsdB1pyJ2wQQifg2XoRyjMLtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbLzvD36BAAJyme2i+wJWaIo1edwDCbqDx6CC47n2FY=;
 b=FtU4A6M/UYb8dzdQ7HJ6NUcKjrakX1pDr/oBcaKcrXFGlUl3v2/AdYFgSZl7qy/v0BkA89mK4TrNVRT6FvunZCr87c58LZdPSKvyBTIlMlGu70hPZkDt7F8MtMSk7FSGi7Z+Jpj95WONPe8C8HAwPrVhbsAx1HZxmNJHuviQZR2qbg+lKUfUuUavBZ6PfcpOkiPJv/q+v8+ij9gPsTh2H+5iVBLfcJLRhYh/bQu7D+OIsrFIaIgzCerJHmkDIM+tYmaUH1jJvkBJhk6EKVxL3NIGEgy5uBRedbKVZsTdAenkgPsnVySdsAAuXFigGcp8aoDp0E/mnUrH7PwaM7+dSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbLzvD36BAAJyme2i+wJWaIo1edwDCbqDx6CC47n2FY=;
 b=0JIE7ZLQCmh8sdAKFoAV7rPTvzel8w5x+7YxcteT9ajTA08yVEyrE6MH9LSp7Xa9aYVsZDLFEvaFHMGXz0UhQUeXdk5zdIZPAA+amaUUHxe0wS7XDsct67QWs2NwsCy8fu27JALmk0/OdBB+RU3HoC+5EVSkhIXKSyWUhs2AVHA=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4346.eurprd03.prod.outlook.com (2603:10a6:10:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Tue, 1 Jun
 2021 16:47:12 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 16:47:12 +0000
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <1622554330.014931.242356.nullmailer@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <6e13f224-b5b5-25dd-9288-ce2deb05974a@seco.com>
Date:   Tue, 1 Jun 2021 12:47:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1622554330.014931.242356.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:208:23b::33) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 16:47:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e51498-07a3-4bb2-1bc1-08d9251ce747
X-MS-TrafficTypeDiagnostic: DB7PR03MB4346:
X-Microsoft-Antispam-PRVS: <DB7PR03MB43461A0B8453460C0DD4A167963E9@DB7PR03MB4346.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0nrHGslbPfViRefT+b86+wVLhybWhht75/6TuGmPQzAb0MePt2rUks+vtK8uu0HmdHUKd187m9XfI8th09tkarQpt9YD5LEFjw4+jIFPjdDbkpL6ZemtqAbI9afEk3SAohtk7ZMPFJGs60EO+T3SYNTkumFMZiox2akFlcTzvO1/UgdLf3so9UopkyJkAf8WZyAsBH3+xXJFEXSQ9GrDGjir32SVe1daYSCo5PdgF7uiesW3SFbkrdh/hRce2Ffos9e//y2nS3zx6mc7XfFNq56g5B9s1ZXATNeW9ZLVGuc+JI/fx4mrhNerGgHaI4PWloEkEFy7p/vIDy8ddRqR1b1Jthvzxa+Aq0lIpayX4S9QOnYz4B6AoYSfYgq8fbQ3KjnOyBAV3sSh7j2LESeantNnd7/hq9v5vevpV8kOQSdhU2hNwp8n19kvneKeLLZCJj+Xi/CndUw4Hro4m/DCco9v3egGh9SNmj5heZjmNpiPku+6HPFnBkBXhEvc8BnDkVcy6PedIzWEKZ3BKA7PwQGg/kb+gqchfpsJjEjMlUyxMnXVHj0fKfn/bN1Cd/4mntG+WRQ4JXqQGPtetEN7YOcrokJLXtFfHm9F0XJASg5+ul7I1/lL05Z19MPHgJsd3gc4XJC9BYHEkLlVM7Yf+LQ5q7EE++51qf74bHqss0TbgXSv4aatpu3B2rFXqmT5Y38mev/h54674pgZgQLiaCjb0GBGJC9pG3J5Tgn/n3DJ+tjH4WeFotdlPlxwC0oD0r/8Dta2YCtgbBzRpiX5A7Xi/r3xrMz8j7S7uPTES4zLBT5T0OcD5a/oxw2/ye7gNTJTAXkPTn2zULP9ZBpJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39830400003)(136003)(2616005)(8936002)(52116002)(6486002)(5660300002)(956004)(8676002)(966005)(316002)(83380400001)(36756003)(478600001)(53546011)(6666004)(31696002)(4326008)(86362001)(66946007)(66476007)(186003)(66556008)(44832011)(16526019)(2906002)(26005)(38100700002)(6916009)(38350700002)(31686004)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R0IzTEVtV2lqNVlOaGJCeGtYcFlFTVpaN1NwR3BuL01aOHMxRmtIWlpzUzBO?=
 =?utf-8?B?UkRNZStQcDRJcm1PUXBzN3lrMEphdGtnTG9Pem9pMk1sZWxleWxIVjlTcDlr?=
 =?utf-8?B?RnQ2K1l5SktMNndTSmlvVEtkelMrSzlmQW4wS0F5MGx1LzJaN20vcWF4dmZQ?=
 =?utf-8?B?ZnBWRGdTYjcxZ2xtSSttODBsYWZYSWNkcTd2RUN2N3ZqYXI4M2xNaFY2aHFv?=
 =?utf-8?B?TDRGbEJqRFY4R0NKY0ZEYmI4ZW1kWjk0c0t0M281eGZYdVlxMUN6bjMva0t1?=
 =?utf-8?B?MVNkRjVDVTlCZUdEdW5rWHpmMDNQbnAvZ1dDVXBZdm9Fd2hocm1XaC9rcmVx?=
 =?utf-8?B?eU1FVmRhOE9KT2MzWEp6cDVad3B0ZnJMKzVCaUVxNWxEVzhHTGNyMk5oRW4v?=
 =?utf-8?B?aERqakQzRUpHK0xDRGZSMnZuSjVvN3BRMXdCeWhHUkJ3eVMrT0JrdUJBWExi?=
 =?utf-8?B?eGdyaU5SOElmUEVKT0JnaW9qRXZLZXFmaGswRFZCbFpzK2R0NTFZUWg3SS95?=
 =?utf-8?B?VWQ5QU1SVm45NFRNbFBCYU9wck9SZWUvc2todlpLT3Vja042VzdoM0J4K2Vq?=
 =?utf-8?B?QmtRSFZDNUhMZGZEOFRRNnFDWldHMnFRU2s2cUs1RUxZV1YxRFJ1dXVPY0dn?=
 =?utf-8?B?QklMblZWem9rNkFIVkl6YWYySkJzejI3ZXVZRjRLNTdBb1Y2eUMzRXFSN2o0?=
 =?utf-8?B?aXEwQ2pSajhzQWZ6YkwvWWxCWjRwTG9HRDVRQ3NrTmxjVGhGajU0VkxhU1FY?=
 =?utf-8?B?bW95SXZnaURGaTF6SVBkdHZscXpBbUw1VDh1ZzlHd3RzelEzZ3hXNnJ4TmMr?=
 =?utf-8?B?MnlkS1JZRFAwRjY5TzFEeXBlUVVWRlgwOG8ySXRZbW1jM1VJSE5abEpZajA0?=
 =?utf-8?B?Z0VDT0ZBMk4vRnlDMGhFbUR6Y1N2VkJxWVJmK2tIQzMwcldYTzVacnE0QVpH?=
 =?utf-8?B?QmJaRzRqcnlmc1diYWNkR2hhRTNpMExJY0ozb1oxLzVvODFVbFprdWw5d0h6?=
 =?utf-8?B?U2FsVllvMGtPOVpYMTArZjVMaks2QlJxMFNCak5aZWswTy8vb1V4VWRYbFpE?=
 =?utf-8?B?V3kyaHREYWswNzJvY1k5SGRIZ3JmNVdpVlpCM2FTRkx4SnNMTjJhWHdXNEh5?=
 =?utf-8?B?eUZxVjl6NVQ1eXNvUU41ZHcrc3lzMzgreUtpZ3RLbGQrMkhCU29MemJnY0dW?=
 =?utf-8?B?UG53c3ZLUkwyeWRsQVM1TEFMZkllYVZUWGN4N2kyb3ZobXUwcDhYRlJhZXBV?=
 =?utf-8?B?Z2pZTGpxQncwc1J2Ui81VkkwWXBDM1NNZlNLVDZYOFdTdHpydnU2NGVxN1No?=
 =?utf-8?B?U0hRcEs5T3RXQW1oQlhNUk5KeURDTndZeVEzMXlvZ09VYmVPOENrMm5OOTZJ?=
 =?utf-8?B?cVRvWXhCd3BZa203QXEwd2pCc2U2WlowK25WTVlSTWdoaU1ENTJTUDZJY0JV?=
 =?utf-8?B?a3lUQTM3NGZmcnZtaGEwNXJsaHNGUXI2cHJLaDVlWDl1MXJTR1NiN0RKalls?=
 =?utf-8?B?T2kzaE9xeVFRajdvbVltYm5vVnh2THJ4RmhpQ2QxOHhyV1l4YjcxS3ArVnp0?=
 =?utf-8?B?L2x3K0xXUEZSRnRPUXY3ZnQ5ejFyVzRwNXRaQzA0R0xNOU5ZSzR4WTFKei83?=
 =?utf-8?B?K3B4V2VnL1h5QU44TmJzZzNmL1Z3VDB2eUdWb29pSmxrVExYS2lnV3c3VTR2?=
 =?utf-8?B?MGg1dGxpK1JhRFpqWGZLbG1MVlIwclpVd2Y2SkRzZGpSUWFjUFQ3RERrUlZV?=
 =?utf-8?Q?NR2aWdTn6eXoWZtSoD9Xm1pcI0ajCacBd3EuLGk?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e51498-07a3-4bb2-1bc1-08d9251ce747
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 16:47:12.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwLhVOJ0kpO3UZchssKT994j14+xGnRkh97VspoyD0bTOHPdW0PkE6B+KxCgTpsrvQZM9ABscdZWrgfLCmKvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4346
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/1/21 9:32 AM, Rob Herring wrote:
 > On Fri, 28 May 2021 17:45:20 -0400, Sean Anderson wrote:
 >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >> a "soft" block, so it has many parameters which would not be
 >> configurable in most hardware. This binding is usually automatically
 >> generated by Xilinx's tools, so the names and values of some properties
 >> must be kept as they are. Replacement properties have been provided for
 >> new device trees.
 >>
 >> Because we need to init timer devices so early in boot, the easiest way
 >> to configure things is to use a device tree property. For the moment
 >> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
 >> future if these is a need for a generic property.
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >>
 >> Changes in v4:
 >> - Remove references to generate polarity so this can get merged
 >> - Predicate PWM driver on the presence of #pwm-cells
 >> - Make some properties optional for clocksource drivers
 >>
 >> Changes in v3:
 >> - Mark all boolean-as-int properties as deprecated
 >> - Add xlnx,pwm and xlnx,gen?-active-low properties.
 >> - Make newer replacement properties mutually-exclusive with what they
 >>    replace
 >> - Add an example with non-deprecated properties only.
 >>
 >> Changes in v2:
 >> - Use 32-bit addresses for example binding
 >>
 >>   .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
 >>   1 file changed, 85 insertions(+)
 >>   create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>
 >
 > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
 > on your patch (DT_CHECKER_FLAGS is new in v5.13):
 >
 > yamllint warnings/errors:
 > ./Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml:16:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
 > ./Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml:19:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
 >
 > dtschema/dtc warnings/errors:
 >
 > See https://patchwork.ozlabs.org/patch/1485318
 >
 > This check can fail if there are any dependencies. The base for a patch
 > series is generally the most recent rc1.
 >
 > If you already ran 'make dt_binding_check' and didn't see the above
 > error(s), then make sure 'yamllint' is installed and dt-schema is up to
 > date:

I needed yamllint installed to get these errors. Is this requirement
documented anywhere? I don't see it in [1].

--Sean

[1] https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html#testing

 >
 > pip3 install dtschema --upgrade
 >
 > Please check and re-submit.
 >
