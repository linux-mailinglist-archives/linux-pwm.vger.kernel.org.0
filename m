Return-Path: <linux-pwm+bounces-2288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDA8D3429
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCA1C23B56
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81E180A79;
	Wed, 29 May 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="FcqTPa7b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F717BB2F;
	Wed, 29 May 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977465; cv=fail; b=etU3rmMSYYC4Pz0BONo/UJy5HZ1OkRZChLEv4mzt+AjAbTZ9QRo44XBnyFJztwnfsCE1LwML+s+afoYZAXSmdy2xfYBIVG3Er8Ad+Q0hRmhLrZOL28243GAiLmoOJgpvtOlm1+z+GkgbZJdgyhtLy8qOElccmVtbawIVWng+yx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977465; c=relaxed/simple;
	bh=r8mJzPA+wShcCPZjhz2oIBBKD92qtvFtUBclUQlaVMk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZpKtILiiSs6bP6DZ7ZKF67RTxhi5kAAR6s8Vi+kUfNr3o+woIYgsWeD1JR9NeeLFGtaLPBA/RRpSisfFigkAGS3E6nPzmFezgl4xX8BEX/+L82rhecBGh3o/Q2Hi8LRav74eq25vUZ9l8awPLOkw86HaeGOpdD7oke8Etmsv/Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=FcqTPa7b; arc=fail smtp.client-ip=40.107.7.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm2WU6PfTW1ja6IbTdyQy5TToFt3X0bgnCsFN8kpbzkU2UVvKxVCKakOU6vwbzxRShqsR1604z/AfPieXd2AdYbyjT+kj/J8CEA3WJ5v9n4kRpdDykSSUug46bljUG4Ad8C4yBcxqoKNh5mhh2Kq9ly53kFh3hOSVgoDTDwg1Xt28GVPfNm9vmRaNgKlzuTQd4c/5M2kBl0wqaFkZUlLhAADSjV9jx50uDngJO+f+tiYgrWW7yEIjqkckD47ftLoEhwf45dNRRmMlZnRajExPVe+3KhDvYRStsGBdSidbo2WauijpKxGH0vb9rLvvG9rOGgT+R2tgRE8+xXVlpYBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4twgtF8AlVCbeh1HQmFfwG+HUW+NPJvaQHfxGiRjt4=;
 b=JkJZQ6t/jC3ajQo161kuAA6v2QpKfnJOJkwFGbHnZ23lxgUEyUW2T6GAv5SrdLxORvrvZv1F3KANoiYvgvJ6aShTNW+4LTKQhI7KHHJRpYuNUB3HGVhZVTS6SKILgoRxA1DadksKjLWblTUVTu5Z8xeQR/GHmR2mjrvLNuCj9wS6axFQuOXZLHZlgmRa+NkEaQP0YVrXlhA8rqWH1GV2BMdc9DzNmbqxt/ep29xHaWG2SY6n59G/7CEx7/MeLSojdaEsZNC+TR1WYEyBTbGHCkzLDTS9y/uVgc1w5k4OiA54AAbsbUg22d4SqAibe2lRuZKTCkmYsJ9wucvCiTCdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4twgtF8AlVCbeh1HQmFfwG+HUW+NPJvaQHfxGiRjt4=;
 b=FcqTPa7bujQK7luWDGhmafQtlJg5+KR+++MH2FbiJLt5fPHVFx89C81wFzoKnsjZO2nshV9RVedJXk6zJmjkNnhSXzJmqYpGrRRzduiY9sDO1BSnaY4H/mxBKt9IPvlL13JGvMt2qXf5uAweG6stuUN9Dm9sxphIPkOghfP3Adg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:10:53 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 10:10:53 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Wed, 29 May 2024 12:10:31 +0200
Subject: [PATCH 2/6] pwm: add mule pwm-over-i2c driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-buzzer_support-v1-2-fd3eb0a24442@cherry.de>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
In-Reply-To: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VI1P194CA0043.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::32) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: dea58056-80e3-41bf-68ce-08dc7fc79e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3dtVmhwVlZubldhcms4S2gyNFk4OXJJc2FCc3RLZEd4MFpiNG5rUVA0R2Ns?=
 =?utf-8?B?OVZhekkvNFpEaFRxdzdkOUNoYWpZWVNUTmlmazRKbEE1WlZydjR6TG92N3g1?=
 =?utf-8?B?ejlaUXIwS1ZOakxaTGFzeXgzQy90ZUNRckdOMHk0bDRqdmZWakhlcnlqZllW?=
 =?utf-8?B?eDh4Y3NNeUlGajJpRHpQU1VpL1FNSm1mTFJ1S3k0ai82akhJSjJtaUpUTzl1?=
 =?utf-8?B?cmVIYURFWmU2K1dkZHZGWEVlNzF6N01qYzAvM2VMak04ZEw3Z3RZNGxyeFB4?=
 =?utf-8?B?NXFxRldZZFJvd0pCRnBVZnhNZllhcVJnYWxoMW16ejRsZnVQOE9KU2NxTkov?=
 =?utf-8?B?T2RCRnlQTGhPUTErUFhhYS9rRzViOTZhL0ZxVDF3SWNTbXI4YUJBVE8zSjZV?=
 =?utf-8?B?U3R2STJ5VE5oS1ZNZDRWY0tqaVhqQzdVbGJwczM1NklOV1hmdnYwUHJKeDlm?=
 =?utf-8?B?anVvZmtVOVRXbGpHN3ZoYklvRWo2SS9JM1Bld2RDSjlpcDF1aWRQSFhwaGNJ?=
 =?utf-8?B?MkdkV1VEbW8zdzhTczMvVnJVdkZOc3B6QzZycC8wZmlLNUNmTUdhMVpiVzNP?=
 =?utf-8?B?bTVrdnZoZ3RGY0FuRE5wcHBuMU5oZlAvVE5nVXJuY29yUklBc1FKa0R3dmdx?=
 =?utf-8?B?MGIvZ0FrbTM2OU8wRmlmMENoL1Q0NFphT2V2aXVLZFdKS0hrVXc0RFYzWnFz?=
 =?utf-8?B?N3VOWk1ZZHkvRjZwOEFYSHY2b2cxUXVmU3RYWHJiUkE3VjIxTUx2eUtUSUZM?=
 =?utf-8?B?RDNBMHJ3WEN0eEJkMHhmTDZ6Z1lYMi9mdDMvdHY5MW1mbTExMXZrRnZWUTJV?=
 =?utf-8?B?ZUpXY1JOeGIzb2Y5VXh4aGxKTXlDZXNVQTVTeVdKUEZOTmcyUmZ0dFVFUVQw?=
 =?utf-8?B?bnpFSE5PMTZ6VmRFaDlMaWxJU1p3aE1MZEltNHc4czhzME95a2RTUDZqa05H?=
 =?utf-8?B?Q1QrRlBtR2Y5QllScDh1SEplTUluRTFNbXl6RUp1K2hrcVk0SlJRcEdVdzVN?=
 =?utf-8?B?M2wrOEpkMTlBUkxMaThmVDF2Ky92UDM0L3BPTnRNVkQ2dG1XOEdYWlROR240?=
 =?utf-8?B?WFJNVVErRE9jUitLMkFnbk90bmdRNlc1STlsWHFRbUx2YkJtV3JpVE50QXA5?=
 =?utf-8?B?bklab1hHNGNqU2k1eWxOUTN3VTl4c0RLYXNjZncrb1dvRFhtd0R5Z2o5a1l2?=
 =?utf-8?B?bXVHbmY1K1hFOWxRdUxwKzdqcTIvTmJJNWdCZzlkb2EraFZVZkxzYmZuN3ZG?=
 =?utf-8?B?MmVwSEJaNm43MkdBak5DTDFnY1FBek85dzBWOEZYSjhwbnB5enNBaTdoSWRQ?=
 =?utf-8?B?bWozcGUzK1FVVklLM2JLNTNiTEUyaGN4TFNUTnFNSGdpZ1RlQmQ0d2F4Z1RD?=
 =?utf-8?B?cHJIeTEzanI2bnJKUHJaV1gyb3B1dWE0NzRTVVFrOW5rZEhOc1BDZk9KaXR3?=
 =?utf-8?B?NDNTVHpQbjNSeTB5WXJaMjNCM1ZIZXdNbVFBM0g3ZmtIR011WTVadktoVW9a?=
 =?utf-8?B?bkZOWnRsQ2xaRnh5amd0QzZoekQ5QWJNbjhlRXRUYkRsZWxhSTlLMWxaQjBx?=
 =?utf-8?B?M3pTOEpXKzFwYk9JSFVtNGZxT0VEUVpKL3FzWi84K0lTSk8wZ3NGd2t4cXZ1?=
 =?utf-8?B?UW9NeVZhTWkwSVpOMUUxTE5YSFQrNGhpaWFvck5jNENxOEZwYlV6bUYzU1lR?=
 =?utf-8?B?RzArRmhtbUltUUl4YmtFTnkzUjFyK0RSTTNlbVhReXRsMCtKeXpmbUxHYVI2?=
 =?utf-8?B?WEVWcHJJZk5US1FmdDA4Rmc2MGNVVEJwcUlBRnNhTWYzZlh5VElLZ3EyWFRl?=
 =?utf-8?B?SzVIK1FudlR0NmhNOTVVUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blIrdDNQSlNqV1E0YjVCQkVOWDh0bWpRZHRydGVadGZOcXVBdkIrZDVVSFJF?=
 =?utf-8?B?RE51VVZONlBkemJzYWpXRjF6eHVvZ2tScnM3VFlZZldqano2QzIzSGZNYUhO?=
 =?utf-8?B?ZVRNdFUyYjE3ME1ZSjdXVUdxZFRQNUQ0N2YxUDNESC9ySWZ0c2pUd3NqdGFS?=
 =?utf-8?B?YVljTEVvQ0VjMTE4Uk44a3BFNGwyYXhYUGVDMlhjbjFLZ1ZtYVZFRk85NGpB?=
 =?utf-8?B?YzAyczk0dlpLZHQwbnh0MnZmTXdVZTY2TUhEK1Z5VisrUmJqR2NraktoQUpM?=
 =?utf-8?B?RmU2cHJ6YldMbkhLcDJzNk81eXNtZ21DU3ZVdEVPa1FQeU9hQWNjNktzTFFo?=
 =?utf-8?B?ZVJFUE9wcjZMaUVEdkZxclowRmp6NHRybktES1J1RG9sK0x1RjFBdnZ4aHBj?=
 =?utf-8?B?S0tUcXhLMGhnMWc2ejVzRHdzNWpQUjJIRnBSZW5tbk5XTlRkWllSekZreWRI?=
 =?utf-8?B?ZjlqVmJ0ZE0yeGMyVTM2MUVKTDZXc216ZHJVandIYmhIQWxIWXZMLzlnTmJk?=
 =?utf-8?B?eFZHNmdjdVZZM25DSzFNOW9IQWczZzU5VFluakFyZW0vanpqTXkza3BzenFn?=
 =?utf-8?B?OVpPb1ZNRGZmK1QvUmlhWktDcG9mR0NOKzRpNVRXdmNPNnZ4S2lFSDQ0TzhQ?=
 =?utf-8?B?eHVTdkRwcy9Xdy9weW9xd2Z4M28yUm83alhZMTBPWDlDdzRTMjBYR05CYjdZ?=
 =?utf-8?B?TVRtc1ZUR2tZWUJDMHN6dFpERjQvbFE5QXRmWm8xVG5mOElUUld4Q082NW1S?=
 =?utf-8?B?SjdnMjkwZGZjQUlTL051QVJGRGVZUHNubmtOSmNtUzREekphSEZnYXpPM0F0?=
 =?utf-8?B?cUtQY0lENmFrZlVGMmRvZnUvcGxSRkZxSFBaR3E5Wnc2MEIwMmphdWdsQTBy?=
 =?utf-8?B?NFphZzl6Zm5haUpqMkZSTkc1OHNWQUJxMFBNWWpxWDdXaUlmSU9hMWR3VDN4?=
 =?utf-8?B?SzI4eld1WFJDSmRmUVJTM3lJL3RnYy9PRFBqL2pZd0hwVk1ac2EzRHJDeHc1?=
 =?utf-8?B?ZlB3bGMrTHNndmVlQk9aUTlPSmU3TGZUeEZIMkd5TXlrSVdmSlIxTDNMSXVT?=
 =?utf-8?B?V0dJZXBkYTB4RG5rdzg1NUFBV1d5QTY0VVpqaW1BSFkwKzdNR3cybFpzQU9k?=
 =?utf-8?B?blpWeGIzTGJiZFFBZVE0cDJlN3JsSHd2WHhqbEFOU3R0UGVxekdEdGZMdTQx?=
 =?utf-8?B?YWNPaUluUUs2V0ZScExJdWF6NTJHcVpaaUJXUVJ4VW92ZkpBaVhLbUNBNDdy?=
 =?utf-8?B?QmVTNnpiSGhRYWliNUZ3UlI5VlZjRXJ1RFFLUFpFUUtobXUrWkoxemh3Q0hm?=
 =?utf-8?B?N3c3V3RDODc0MGkxOGl6WVBzU05XeGk2bDBFYWpBamxEd0t5dkk5Z3RlMTN0?=
 =?utf-8?B?Mjk4Y291OXZ2VXVpQWhHdnBsMVFLdm9sQ0pVY2g3Q1hjQlJ0U3ZCeDFmREJy?=
 =?utf-8?B?Z1JyMDNGNVArN2ZNN2JBL1ZseFRleHhpMHpVZSsrSHA4K09VKzNYaGJ0WTZi?=
 =?utf-8?B?S3lSL29IWklsc0c2bWNEeG55andPZkZ2Y1JlTDdrK1EwWU50cEZ4d2JLemJn?=
 =?utf-8?B?ajRHNjZMNG1FMElpVVNqN0xPaTlpMzZaRmt5WGR4WnVGRVFONk8vYW5mdmxV?=
 =?utf-8?B?R3pKZFdnUUpHMzN6K2JZWkZMNFFpWEpOc0JKVFR4cWVyT21GM3h0ZXJBSUU3?=
 =?utf-8?B?NUt3WS9FVXd5ei9rd3VSOHdoemppbkJxM25vUWt4S1g0MXRQQThGNnZXMGRB?=
 =?utf-8?B?MGUzVkFKZ3NDSy9GbG1wTG84eEttTStCdUtkUjQwYTQ1ejdUeHQxMzRQaVl1?=
 =?utf-8?B?MVozUjNwb1RZN2ZtcVRBa1BncWF4QWdiV3BzNkZLcE5YdGszaElIb0RzVHg5?=
 =?utf-8?B?cTltYnRZalJuYVFCR2llS25JMkR4VTRXWE1aMGRtajZoNDdCYnUrdG12dysy?=
 =?utf-8?B?ZEcxdXNPbnR0ZnZrN0J0MisyUUsvWHFrb0Jlc1hIcFRxMzNmNWladVNxRDlC?=
 =?utf-8?B?QWxrV0tqNnlrN2FNTUhna3N3T0w5RHN4Nmp0RWdaVnozUjROdkVKMC83bGt3?=
 =?utf-8?B?Rkk2ZjE0SDhwOTYzamxuUWhhT2lJTHpBZC9SdjFaaUo5TWJKQ2FLZ3BRV0ZI?=
 =?utf-8?B?WVJCUzNzUE5DRFRQOVM4ZVdSVnhsSTBqSldPdVZsV240MDlpS3JCRFdNY3BO?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dea58056-80e3-41bf-68ce-08dc7fc79e07
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:50.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IR5b+ixpk4cubhVhEXG0nLdlgDgiikNQEvDfbRZGzgnalq0iOwerLzZEv4VB29QOkjWXOuimTnQcqHWwBoZJpFUuzkmwJR/j3gvOE8K9Clc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Mule is a device that can output a PWM signal based on I2C commands.

Add pwm driver for Mule PWM-over-I2C controller.

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 drivers/pwm/Kconfig    |  10 +++++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-mule.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..eb8cfa113ec7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -425,6 +425,16 @@ config PWM_MICROCHIP_CORE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-microchip-core.
 
+config PWM_MULE
+	tristate "Mule PWM-over-I2C support"
+	depends on I2C && OF
+	help
+	  PWM driver for Mule PWM-over-I2C controller. Mule is a device
+	  that can output a PWM signal based on I2C commands.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-mule.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..cdd736ea3244 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
+obj-$(CONFIG_PWM_MULE)		+= pwm-mule.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
diff --git a/drivers/pwm/pwm-mule.c b/drivers/pwm/pwm-mule.c
new file mode 100644
index 000000000000..e8593a48b16e
--- /dev/null
+++ b/drivers/pwm/pwm-mule.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mule PWM-over-I2C controller driver
+ *
+ * Copyright (C) 2024 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+struct mule_pwm {
+	struct mutex lock;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config pwm_mule_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+#define MULE_PWM_DCY_REG	0x0
+#define MULE_PWM_FREQ_L_REG	0x1	/* LSB register */
+#define MULE_PWM_FREQ_H_REG	0x2	/* MSB register */
+
+#define NANOSECONDS_TO_HZ(x) (1000000000UL/(x))
+
+static int pwm_mule_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct mule_pwm *priv = pwmchip_get_drvdata(chip);
+	u8 duty_cycle;
+	u64 freq;
+	int ret;
+
+	freq = NANOSECONDS_TO_HZ(state->period);
+
+	if (freq > U16_MAX) /* Frequency is 16-bit wide */ {
+		dev_err(chip->dev,
+			"Failed to set frequency: %llu Hz: out of 16-bit range\n", freq);
+		return -EINVAL;
+	}
+
+	if (state->enabled)
+		duty_cycle = pwm_get_relative_duty_cycle(state, 100);
+	else
+		duty_cycle = 0;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_bulk_write(priv->regmap, MULE_PWM_FREQ_L_REG, &freq, 2);
+	if (ret) {
+		dev_err(chip->dev,
+			"Failed to set frequency: %llu Hz: %d\n", freq, ret);
+		goto out;
+	}
+
+	ret = regmap_write(priv->regmap, MULE_PWM_DCY_REG, duty_cycle);
+	if (ret)
+		dev_err(chip->dev,
+			"Failed to set duty cycle: %u: %d\n", duty_cycle, ret);
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static const struct pwm_ops pwm_mule_ops = {
+	.apply = pwm_mule_apply,
+};
+
+static int pwm_mule_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pwm_chip *chip;
+	struct mule_pwm *priv;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	priv = pwmchip_get_drvdata(chip);
+
+	mutex_init(&priv->lock);
+
+	priv->regmap = devm_regmap_init_i2c(client, &pwm_mule_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "Failed to allocate i2c register map\n");
+
+	chip->ops = &pwm_mule_ops;
+
+	return devm_pwmchip_add(dev, chip);
+}
+
+static const struct of_device_id pwm_mule_of_match[] = {
+	{ .compatible = "tsd,pwm-mule", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pwm_mule_of_match);
+
+static struct i2c_driver pwm_mule_driver = {
+	.driver = {
+		.name = "pwm-mule",
+		.of_match_table = pwm_mule_of_match,
+	},
+	.probe = pwm_mule_probe,
+};
+module_i2c_driver(pwm_mule_driver);
+
+MODULE_AUTHOR("Farouk Bouabid <farouk.bouabid@cherry.de>");
+MODULE_DESCRIPTION("Mule PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


