Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572F3B74BA
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhF2O4d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 10:56:33 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:25826
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232521AbhF2O4d (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Jun 2021 10:56:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YENoOnv6y13hJqBXwUisp8bZ1LizzzTm68f5PbNM1fCeV5+6SgIniszwWMrs8Uzz2/Dpz2wKyiCvAxSoXuqcc3EJLtd4l8aZm95Vuxs1D4SgBfQ/P5COHpgl8UZGh4OzP9oJZxJaZQqXu3MCEjRKl/zrfCDZR6V1tHI+NGZQ2W1fp/Ib8QG6FAtx81dwZVRJ81UFGTEbznBQ5UymMHkLafYOz3GaHX3W4PA3v7uqlis0Zck5eRmjDRnAR20gaCXUJqNZkOwDMWQp8An2UF9ryzOIjfg0WDlfPMY3Y4nreJDAGf4MLIvXGn/sHVGiLO8hdKz7rvFydBzdXXWG17jCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xASGHok0Y+lkd1wJVepw+fELEYTWcnwFidGaX5Zzbfw=;
 b=lAmxd9AqS84A6vtIaD3u4DMIKRjBPYdO+jALYK1lPWiWLKU1Ekkxb/JWR3Ln3o21tXE2kdvzGu9m2hDIXG+GqCK263TaFUVoFFLGC44c7gdl0odVLAZMDoHdovLyS5Kl2Z1n+RSkh5WmemPrw9Y9yJJoW0u8rgVbQTmfM4J/EOdTHOvQ1w4k5XXlrJa7v6K9q4iEof5d4FbiYzGq/Wmnjw3xHlVuBUJWwX2Sh608MQspNOpubhEJR2jcM7Cm58vj04TvBlTPLVBfrccfGUBzSc278o+4scEJpFawYAw9hI8/SVYwso+gxRJsYh4JkLv6KnuizxFLj/YMefWRQwBg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xASGHok0Y+lkd1wJVepw+fELEYTWcnwFidGaX5Zzbfw=;
 b=RpDzLr4BNfYMhm5CY9KlyS/hM9XorxRsCoWY9lCg/QconjbKE+zaAG4r5FGnMlyNelag5ooi09TpJyxXIsi473YUl/cRPbSmHbI7vvllaiNzdu5WxxRll1GV+QtkdAzVV6+Ct6QDwJtr1bN7t+9a8jEbVQ3Qp7/SqxNLfEBNsFA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6762.eurprd03.prod.outlook.com (2603:10a6:10:20b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 29 Jun
 2021 14:54:03 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 14:54:02 +0000
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210629083851.dsejopbe3pbgjer2@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <4680f44a-f3de-249c-3af4-0858a70762b8@seco.com>
Date:   Tue, 29 Jun 2021 10:53:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210629083851.dsejopbe3pbgjer2@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0376.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0376.namprd13.prod.outlook.com (2603:10b6:208:2c0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 14:54:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d6e0bb6-553d-46c6-34af-08d93b0dbc25
X-MS-TrafficTypeDiagnostic: DBBPR03MB6762:
X-Microsoft-Antispam-PRVS: <DBBPR03MB67621F11FBA76845711D23DC96029@DBBPR03MB6762.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dq9+JJTWnn8durhT1Pd/f0ggAFs7KzlKlNIUYWoNHDE3C8n731LGFzYtpLuVCzKCpNr67W4euH+lD2X3hX+TJ/VzwttnKimZh9fYCfgNIOu+GNmCY4THNEW6orvUWpl+7sJTBY9oPKOYt5uXQ+dCodkGsHmtWfRnVbiSy8dgNNXr7uiGQk5eaMmRd/BYHeip9av/2Icr/J9lSgPvz/jQT6zbkWGL1K+y2mPp9GSnu5Icnojmaw26ScGr7CWkZnArNcWnpI19zrbBK+sivj+cQLGuUoLh7yIWo7bz3Kg4zopAJ7ieK78M6AVe2Xj7iTEuPURofGu0H0rWlZuJoiC+U51raotdo84Dvw/Thx42m5gnKkKJxPJXHW1ADxOaysFCtBqRBjvof1ZbzAy89dgeeTJ0y8J3y6Mds1mCpoSxSlvtzddRDmZpjQpx8Cy1j9yto/mJRrCYFVHevtAGnzj5PxuIb8TvCdJ6XUGSdy/ekVqLDZ86/9PVLZUJRW3EfIih5vWZPOlVkiL7dx9h97L3Zj/vvPUOpSsigPZW2+NvHCKFSMOE+0tWkBi9Tn6fQ4FUVT8G4oV3UoeRIWkpoWxWvAvWcp0stB5HcbzIwRvieXZsVAuKOtOoob07QxaNH4XH8cmpQX9/9p1mGu3gGL7v4ZXsoDGZqskfVLqEPGqzqsvkbTPLh1vKlfBCFoYd0I6zoT+ltc65MxHgNLbyvjYhHuQ0gYFIyTomuS7pul7PZun+P0LmFA4iSead4FSaWlylvcq/1N2NrWEuqdJg1l/BQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39830400003)(366004)(376002)(396003)(186003)(16526019)(2616005)(316002)(16576012)(956004)(54906003)(4744005)(26005)(4326008)(5660300002)(52116002)(36756003)(8676002)(6666004)(6486002)(66574015)(53546011)(44832011)(31686004)(66476007)(38100700002)(38350700002)(31696002)(86362001)(6916009)(8936002)(2906002)(478600001)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?zFQk4YeK3S/ODN96WXEegWzUNGx+wmB65U/7gMJK1NpUFpd6xkeaFO1o?=
 =?Windows-1252?Q?sAiDVI11V51Hmbyfl3dQqECbESBWj42MjzqhnQPrnqHJJw1kf0tWpz1Z?=
 =?Windows-1252?Q?orqAfrwXVj8jM+V/iduSLSiVvEuhwBL4O2Z6JqYugHtjLntg6CxepJ34?=
 =?Windows-1252?Q?SmKkEpTXWMT0Q7inXB+rLhTgFH7dCD3MqtVqsFksr9AqKtNh2NRQGqHu?=
 =?Windows-1252?Q?u1Xb79/icKBfboVRop1uQDG9lF1QVvZ9c4YqeyujjCClZtLcrsSTf2eF?=
 =?Windows-1252?Q?d+/7e3nzQS8UHcPNcQr7kym23Ub0HW0iYBIaZUWo+lfi9zVKQJfIJYy7?=
 =?Windows-1252?Q?BdSZZsMX1jfhTHsoLAQEZy7fGGE/7U1x0BalwqmtiZpBvguJ34tus4Mm?=
 =?Windows-1252?Q?cJmPle9tf2Cxk6OL+xMaMO9hMg2mjhh87A7nIF3A+KidnJTkcsCnA2er?=
 =?Windows-1252?Q?FuWD/Pox8AZUs/jTqCi0o4/4EdXrOC2vC+xLpw/ByWK/OzMO2u8+15uw?=
 =?Windows-1252?Q?WL1ZeGXhS04eTTf1INqYMj811UfucYi42IwZJQ8n5wTCWN32ZSwgFs0W?=
 =?Windows-1252?Q?O5u7UF3qYoEB3O6lx7C2ZEa0gNvIuX/YMsfqcCMyozHDoH90UWuTeROf?=
 =?Windows-1252?Q?2f0w/9td/qDXyM6ZTBlYgZbGK4Q03GnsGITcqFvHRdWW1vWylFkFY3gs?=
 =?Windows-1252?Q?Kq1J4imUaSQRNdzqMXDGX2AYI+KTbXvqLgwndFtaj0GoAYF4rM06JTwA?=
 =?Windows-1252?Q?/3KzyiCRw1MAgghPkrvmu4xDB70Dm7yGbr8MvLmx1rISZ6p9MX4tQAzI?=
 =?Windows-1252?Q?x944XpRC/sm2RASHLm4f4rnJb5aF0RLCilbSMjbAZ5X6C/36UJqV3ns3?=
 =?Windows-1252?Q?rQaJ6HlgyFPm2UnwHmsT532yb2lZDhusbhfcPBqlITaLdQ/hJInU2c/f?=
 =?Windows-1252?Q?uQnf3KAKiaL4f/41ZAGpIjgCVnIo+NajJXW59JcCmi2dX7oxx+4msVRE?=
 =?Windows-1252?Q?ARb3OAmR7DntwdzxEAxcDaSD7j/JO5kAROsA9rZC43PQ1krhD+xZK6oB?=
 =?Windows-1252?Q?kU1t2nvb9boIO3gmfFjPv7iTueHDUun8n+zV+NK26rKPU4nmvaftFfII?=
 =?Windows-1252?Q?onRPPfljqKVpssmGAbkfko9Xfz7vqegSvSLi/wit8gJmUgyqdsN+QIdR?=
 =?Windows-1252?Q?HydrdbYYz6taRojeNx1mJvVa5lTTdnvfhH79kg49+WGLQrtxAViy+d21?=
 =?Windows-1252?Q?ivulhz1On3W9fJOus5o0gKt7PmMxynZZbI525pb66GsbmQGmMxePLAt2?=
 =?Windows-1252?Q?+qrRjIbFB5v8KrUTc8a2p7NzgqjI+a/0te+VR23uDH0rg9l9qa1MExhH?=
 =?Windows-1252?Q?lhkSatIdHypIRRHquCBcrkvgZam8EOUmLRDmZGse+W0GAfORcSksTIl4?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6e0bb6-553d-46c6-34af-08d93b0dbc25
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 14:54:02.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEyGWZMaaVu+fnYVErpiW63drVuciIEFR2680VbhcydVgGzeliTzKaMp295+voIYHYPhayfm3Zj76kd+8S7zjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6762
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/29/21 4:38 AM, Uwe Kleine-König wrote:
 > Hello Sean,
 >
 > I wonder what tree you chose as a base here. I found tags/v5.13-rc1~44^2
 > as a tree that your patches can be applied to (and tags/v5.13-rc1~44 or
 > later doesn't work). I recommend using

Hm, looks like it's based off of pwm/for-next from April. I will rebase
onto something newer for the next revision.

--Sean

 >
 > 	git format-patch --base ...
 >
 > . This makes it easier for the responsible maintainers to pick the
 > right base and allows easier automatic testing.
 >
 > Best regards
 > Uwe
 >
