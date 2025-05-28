Return-Path: <linux-pwm+bounces-6157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C61AC6122
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 07:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023AF189DE1C
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 05:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6B1F582E;
	Wed, 28 May 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PXveXZ8Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010071.outbound.protection.outlook.com [52.101.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F917A2E3;
	Wed, 28 May 2025 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409497; cv=fail; b=UwLDZGPbHHmUFo2POGDVDnel5y1HHqZy/af584G5krT27QBjhxfV9NF4W32DS5VofImgNO8JLlygEEW45CGsclGnap1YpzhfvNKQkHnmIfaUr5i/KMV/fT39GvEpRZBrg3uSRNsg2p9n0Hsu1nNHxAHykzWKufeD8v/9VevUqyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409497; c=relaxed/simple;
	bh=iRS4RunBA+4i/NcF4d0TjS8e2Z0pulw7EZ26OWgT8QA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrxVMWRkTgwLRNJl7oIW5lZLmC2UApSB0ZJD4aikm0HibQ9zNE6sjP5XA0wJlG/ev6Q4uJtc24Uzxo5A8RGIEr66HdTcCQ4Y+5TwYAkm5DZznCyyHVvLOE74yEPdKSEIVbwTyGYID+Ejim5Nvu5yrXda5axdgLAQqjO14ZA8wWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PXveXZ8Q; arc=fail smtp.client-ip=52.101.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCMdFyOmrfRiyNKyPt626rFj/qXEybions8VzOI8FSrl/XlcGCZxRz71geVlMT4Dq4i3/AAEWaBfsN0LpqvBvuWv0ltb9ZGGsxcBWzywDyNJ8wLv2GtIlyatGu2Up/PlDvKC/dNzIjaAu/3m6I9KwbtKmaplbNp4j/O874gojO5yI79FH0F+wrJoD53TdfymMIRroFn846k82A+7XpdBDXcOio3TLwMVDzFSTBcY3jEpz85/fO7n0LEh639ElJCpzc02ylyq6p3qqC+7syI+cqJjpMYcD9p9BmyiqbNO4oWYnOxrqhyDQc1yYixZysULP0PAhfsLa6zmOYq1wyTflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRS4RunBA+4i/NcF4d0TjS8e2Z0pulw7EZ26OWgT8QA=;
 b=pyxfyt+w6bMej+lyhU7L3hZIVdLh//yPmcm89WujVTZ3lufpDgQXB3lmt7aR6wMDRIIBN8X7yl+KHsjvGOiO1A5rrkU5Jv76gwMPSUGT4mTCcnh0ARnbS9F5g0Ib5apQK2CeJt85xXg11nd92ImklCU6VrqEy6Bo5T8HWW+OAeeolQGTeNv2nKJAoGTsx/2ogk5x1NPVLbCkv83sNLhMGubAM5yfgdYVMoc5Yjp6+whTfLA1663ktSc1j9XDAc7vzGKfTqyHqJ0Ep1ZQ2wJ2sruldRTnnUB0jC2h5+qBjMBoDWycnqObOSjjXkj8aXXlnQG9sxias2QhRfNgxulaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRS4RunBA+4i/NcF4d0TjS8e2Z0pulw7EZ26OWgT8QA=;
 b=PXveXZ8Qbr/Q+0QYh7MhFU0bXrPEBaxI58WOn/nEo1KAHOd6K3NIt5Rug5aHbBy9+rD3FKvUQxDThprEOkKN5DdmUX1u0edPqlJIBFvpaDT2que0KWyJurWs0El0772kBArKerUv9SxHmyBjUsqm4bFcQcoK5jWBM0RDmMXmgmM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB8677.jpnprd01.prod.outlook.com (2603:1096:400:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 05:18:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 05:18:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
Thread-Topic: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells =
 <3>
Thread-Index: AQHbz0oes5uQfrNUZ0SMYzbUxXKccrPngOag
Date: Wed, 28 May 2025 05:18:10 +0000
Message-ID:
 <TY3PR01MB1134674C4CC031F93106B9CD28667A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB8677:EE_
x-ms-office365-filtering-correlation-id: 13b8a21f-8508-422d-564f-08dd9da70a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmtzeUNIbTFvY1NSSVNIUEdycHd2UExqeW9CVmxlemZ5VGdVbmlBMTF0RjBu?=
 =?utf-8?B?YjZWMXVFbnpKZWF5U1FRc0lVMFhUQjVYSnUzaVYrY3Yzb0tqRnVQekZ6emJs?=
 =?utf-8?B?d3Y0dGdBdWtPSVBuUTRFMlA4ZVhuc1RFUXR1VExQR2hXN3RyTHBUaXloeVVj?=
 =?utf-8?B?bVhpdUJXZmxFeHdzdjZINHdHSFIxd3lCcTR1YXkvU0lqWDNKWTBBNW44S1dV?=
 =?utf-8?B?WEhKaEQzVTY5dHk3bmJwZmpUV2hYb28yY0VhTUNML0NuZUVSRUhUT1h0MWVC?=
 =?utf-8?B?ZzlvcHFNVHNIQ2crcHlWa1RLck1UTFk3OU5FUjV6RlFpamhqNEtibzVhU3VC?=
 =?utf-8?B?Z1J3Q2w5UTFOWmczanI0WVdlNDVSdWlFa0swcW05N1lkUlpydXFPMGovWWhX?=
 =?utf-8?B?WUlNZGprTTRPYmNWOWF6WEtzeXdZRTVWOHJnMG5wbUw0MXFidTYvTDFPeU5V?=
 =?utf-8?B?bWdQYnBZUmVzTkRRdFVrYnNobkRuSlJFblBHM3ViK05qd1J0MTR6ZUVlR0x5?=
 =?utf-8?B?aUtVV0dYc1JUMGtheGk5MTVCV2hKM0llMU9oR0hPcmVzWTlWS2tmWmQ4RVFn?=
 =?utf-8?B?a2xMclQxV3loZXBMQ3g3VUhzSDJQbzhSaWg0QVNiRVRDVnFhQzZUR0hlU2k5?=
 =?utf-8?B?WDJ6amFrVnlSUlFQUGNwZmIvMnlraUZwbnNOYm1YeGtLL1hTR1hxQ1hDZjEx?=
 =?utf-8?B?V1p0Q2Nta08zbTl0TTd3dDdsRi90VExHcjNHSGJmNEtwNm96eTR1K1hJVzRP?=
 =?utf-8?B?cnVaMVhCZms2MzRjdm9IYmdLK01rWGxYV0pZQ1VNZUxNS3Q1by9HQUdMWmtI?=
 =?utf-8?B?eHYxVXllVDBORWxxbTlMNTl2amdid09zaUh0cTgrN05FWmo5ZXZTN2Ewcllm?=
 =?utf-8?B?eEU1Yk5LQWhqNGxtdFlOenhIQVp2Mi9LZ05pSHZpb3BKZGRWcG0wdjUzODZP?=
 =?utf-8?B?dUF6VVpQNzEveitYS3doRzVPVFR1UzRRZFFQYjZ3Vk0zUSswVFNHQS9uR1Fj?=
 =?utf-8?B?RnVJaGhBZW1jUkV6TWlPQUVMLzVJSEFFVml6d255QW0wYkhhcFQ0LzJ1b1Jn?=
 =?utf-8?B?NXZGdXpyWkRRMGROVUFGZVpmS2tzQ2svdlhOa3VrYU9DanVVS09EVXhJQmZ2?=
 =?utf-8?B?SHh5TE1JQjdPbVBkU1hiSmJPK25JSGJUOWpLSXRGaFVXdHFzNlgyeTF5QnNa?=
 =?utf-8?B?Tll3czZsdCt5SWZWRDl3L21aVnRNbk5yMWZaQjc3T0hSOUtRbkZMdDVHSnRn?=
 =?utf-8?B?TnNUZDdsVjdzZDN1bFFNMjZYT3ZkNEZZc0lhb0xHcUIveUxKSGpQalNWRnlZ?=
 =?utf-8?B?S2VLenp4UXhVWmpXdEdSWFdrZzZ2TThianZVbVJnQURlL1R1VUcwazZvekRY?=
 =?utf-8?B?aG80Ykg0dklhc3lvSGFMT2prTC9yM2h0cGtuL1IxV2VyV0RZdVR6Z3VWVFJJ?=
 =?utf-8?B?M0htS1pSZkRpVFo5U29OUlJhd1drWitRSUFab01MU1laNHFwMEtOWGxsVU1L?=
 =?utf-8?B?MEVJcGI2bkpocHhFVzBEemZ3M2VmMnR3VjZyWkZoTXVHcTI2YjloazR5Uk5B?=
 =?utf-8?B?OWhuWG9iLzNFMUJBUHVnWndGOWpwQjcxYkFxU3U4RkpHSFBrNjFBTnpqQ0Iw?=
 =?utf-8?B?Z3ZLS3RacHZRT1YyOEVvcFFnM2xFZUIxSUJuWnlQSFNqN3hIckgxQmRDYUpt?=
 =?utf-8?B?U2l3TkVoQURtL0YyYklDVUFXNnBIR2paSU5scC9FamV2MkhxdU95KzhsTnZq?=
 =?utf-8?B?OTA1SHVqcm5KUnhkUCt1dG5CQnFLY0xSRE5hdHNhNE5UVTFMQndFYTlUaTRK?=
 =?utf-8?B?SHExRmlNcHRnQ1VRK0YzS3hWYm9ieXFablRzd1JGMitKQVpHNWExOHMrU0Fp?=
 =?utf-8?B?YWlkTEsrVndseUkyY1hNU0FwN2tUenBBT09jU2w5UytCNmtuL3JGS0tPQUR0?=
 =?utf-8?B?MnBSSlFUMDY0MXN4YStPcEVBVHhvblJ2MWZKcjUxN1NZQmYzS2YrQ1pEcExT?=
 =?utf-8?Q?jZ3LCGpG5Fj5FjraVg4hHjTM/dvYsc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDE0bUphb2M1Z2VWUUtrdEtpM1RzaTgrUlZGeUREZFRhR0lMeUpmTHJaemRG?=
 =?utf-8?B?YXpBY0Zsb3RkTzVTOGt6amYxYXo0MTFPRWpoWkJUMGRocGlVeUxNWUlOaElS?=
 =?utf-8?B?ODNqcnF5d3pMN0tUbzRuU2lIMHdNSy9ja3pzUmRBNG0wU25xUFliZ3RzdUJM?=
 =?utf-8?B?QndWTk1abCtIQU9uckw4empWNjVVSVdXWHMzTlNzVkdTZWZkUXh5ZkErMEpq?=
 =?utf-8?B?NHMyanRsK3dzamhMNjRCYi9qeUxLZWcvNGZweWZDa05qdzA1MkFIWG1FMlR5?=
 =?utf-8?B?UUpWT0xFSEF4YzNUcFdoNk41OXAvU0p6V21UdHMrNHI5dkJOK3BKRnFOeVdo?=
 =?utf-8?B?N3M0TzJ1a2JsWUhYUEtLWGJvUnZSWFlWUUY1UXR5Wnd4MUpuNHpueUxmUHpS?=
 =?utf-8?B?ZVdlNUlGZStDRlNlSUpuZ0trS0ZuZjA1eVpIVEVtNUhzOUNYTytkM2s2SmFo?=
 =?utf-8?B?N2VoaGwzZVRCcnJxenYxL0MzSFYyOHJpRDBlOW5zZHczRCtWN1NUWU1kakZk?=
 =?utf-8?B?UEd4U3Npc1NaQzdmMzRqdHJONjkxandyWG1OMG4wRElTUUlTUUljTlN5M2lS?=
 =?utf-8?B?ZVg5S2xETy8xSUlwOXBKOFRuTllyT1M0dkcydVoxamc1NlpwYVVIL2xlTkNB?=
 =?utf-8?B?OXBBaDJVUmZaZCs5T3lZVW1XckpYUmduMnZxUWJHa0ZOdlFjVnlKWFJyUE0z?=
 =?utf-8?B?c1JpU3FFZjlkM2FhVnVHNjZCOFM2MzB1NERzZHlMWUZnS0RzUlFtQnhadkN4?=
 =?utf-8?B?bS9yZmd3Q3FpWC9wekJqSVh2Ty96U3haUy9pQWpLV3ZDcEZPc21iYnNQNllt?=
 =?utf-8?B?N2JkY2ZreDhoU1A0WEJ1bXoyREZDMDFWZ2kvc2k2eXVPTzlJMWZiRjhrbXps?=
 =?utf-8?B?QytURlBBa3BtaVNPQlpsdS9lM20wZE9iNUtIcjNmQjBzdjhCbk5SME4rTk8y?=
 =?utf-8?B?c3hsLzU5ZU1YOTBHbmJhajNVcHVLa2pTcG9UT2VKTkVhVUJOSXlyYmlHelpN?=
 =?utf-8?B?aFZINUV0NmcvVXNRYkFOUEhFYUVYU1piVlFGNS9xS0s4b2JrZW1kTVhuTWtv?=
 =?utf-8?B?UG5qUlFoU3hEZHNIOFdFSm01cHlRcEk3VVgybWxjYlpEYTFmY1lVaFJ5QmtD?=
 =?utf-8?B?RTNiUzBOT1EvWHBsNk5HK3IyaDNxTEErL0htczNEaFlOS0xBQi9mYkJJZGZG?=
 =?utf-8?B?ak16SGlvM0Z4dTgrN2RtSHdVQXpWeEdCd0xTQ1dyQ09zd3gwWFdIRkV0UVM0?=
 =?utf-8?B?Uk91blVGdXhwYWpCZDAwVUM0a3p3cm9ucXpDZmRkTW16MFJDMUthc09lZ2dB?=
 =?utf-8?B?M2REVG83YmQ4UW1memplbk1KM05JWDlSbE0wUFliTkFTRHBLTHdpeU81alMy?=
 =?utf-8?B?RTlVRUpxaDkxOXd6QzZRWG1kVld1Si9VOFN5VGp5WFI3ZmgxYTY1UlprZ2Yx?=
 =?utf-8?B?Ym9vanVqcWE2WUNmd2xqMko0T0ZSLzBvMjNrUVRROGZmb3NheUxVbHIzNTBY?=
 =?utf-8?B?V2VIU09oNTVzSDdKWGVoVWduZnV2ZnlSR3ZRT25DOVJ2VytQSlo3eHR4dytB?=
 =?utf-8?B?TFpMdEFwMm5tSmp6eENuVjQ3Skd2SVdzc0loTmF1Vnc5bko3NmtoMTFnbDJ3?=
 =?utf-8?B?SGV4a3QzWmlLY1pTSEJvWnk3bW9zN0x5YUVCck8rdlpSd3Bia3NRaTY5d0tL?=
 =?utf-8?B?UHRaS3B2V3hsMVNtNHgwakNMTE9Gb2g3OUJyYUNheE4rMEFzWTByZmJKT1pl?=
 =?utf-8?B?VnM0SGU4KzNKL3hET0N3QXJJamtWeVBUSlZiaG9CSlI5RERvZjVxdXdZUDNt?=
 =?utf-8?B?SVQxQlphU2pPaEVNcE1Ha3NpVDlOaGt2SHNzR2FCNXlQMDNnU1hlTWhSUjdF?=
 =?utf-8?B?YjJPZlVMTS9YbnhyUHJKU1ZBb01abkppV3RXT0Vmd2hzN2NUZjNmZ2RPLzdr?=
 =?utf-8?B?QkRxVVVuQm9YS1ZpRWJLdGxhWkZxUEJwRTVWN0tkNThNYXRJekpYdGkybElL?=
 =?utf-8?B?amdkV1JiVXdnQTUwemY5Zk5tR0U1Q2lvK01SMXZQdHF1b2VDbFdOM1pnUnhN?=
 =?utf-8?B?S3lhUFVHaUFKNTJZaXhFNWNGb0JJYkdUVDRKYzlPVEtnY0NQWGwxbUQxd3Nh?=
 =?utf-8?Q?DETXtyPgix5fOrHdmPtbw9ayt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b8a21f-8508-422d-564f-08dd9da70a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 05:18:11.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nlj6AfRC5pYJkcTsrVP8bJtY7dWETdqSIsMnaSnk9i0GYqGzCw/vadFoUhBdWYqwiU0XUMenD8XWyx2woROo0r8/VykU/UcyfdsbmqJNsSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8677

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxp
YnJlLmNvbT4NCj4gU2VudDogMjcgTWF5IDIwMjUgMjE6NTgNCj4gU3ViamVjdDogW1BBVENIXSBk
dC1iaW5kaW5nczogdGltZXI6IHJlbmVzYXMscnotbXR1MzogVXNlICNwd20tY2VsbHMgPSA8Mz4N
Cj4gDQo+IFdpdGggdGhlIGdvYWwgdG8gdW5pZnkgYWxsIFBXTSBiaW5kaW5ncyB0byB1c2UgI3B3
bS1jZWxscyA9IDwzPiB1cGRhdGUgdGhlIHJlbmVzYXMscnotbXR1MyBiaW5kaW5nDQo+IGFjY29y
ZGluZ2x5LiBLZWVwIDwyPiBkb2N1bWVudGVkIGFzIGEgZGVwcmVjYXRlZCB2YWx1ZSBhdCBsZWFz
dCB1bnRpbCB0aGUgaW4tdHJlZSBkZXZpY2UgdHJlZXMgYXJlDQo+IGZpeGVkIGFjY29yZGluZ2x5
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BiYXlsaWJyZS5jb20+DQoNClJldmlld2VkLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQoNCkNoZWVycywNCkJpanUNCg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3RpbWVyL3JlbmVzYXMscnotbXR1My55YW1sICAgICAgICAgfCA3ICsrKysrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL3Jl
bmVzYXMscnotbXR1My55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3RpbWVyL3JlbmVzYXMscnotbXR1My55YW1sDQo+IGluZGV4IDM5MzEwNTRiNDJmYi4uM2FkMTBj
NWI2NmJhIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dGltZXIvcmVuZXNhcyxyei1tdHUzLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3RpbWVyL3JlbmVzYXMscnotbXR1My55YW1sDQo+IEBAIC0yMjEsNyArMjIx
LDEwIEBAIHByb3BlcnRpZXM6DQo+ICAgICAgbWF4SXRlbXM6IDENCj4gDQo+ICAgICIjcHdtLWNl
bGxzIjoNCj4gLSAgICBjb25zdDogMg0KPiArICAgIG9uZU9mOg0KPiArICAgICAgLSBjb25zdDog
Mg0KPiArICAgICAgICBkZXByZWNhdGVkOiB0cnVlDQo+ICsgICAgICAtIGNvbnN0OiAzDQo+IA0K
PiAgcmVxdWlyZWQ6DQo+ICAgIC0gY29tcGF0aWJsZQ0KPiBAQCAtMjk5LDUgKzMwMiw1IEBAIGV4
YW1wbGVzOg0KPiAgICAgICAgY2xvY2tzID0gPCZjcGcgQ1BHX01PRCBSOUEwN0cwNDRfTVRVX1hf
TUNLX01UVTM+Ow0KPiAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmY3BnPjsNCj4gICAgICAgIHJl
c2V0cyA9IDwmY3BnIFI5QTA3RzA0NF9NVFVfWF9QUkVTRVRfTVRVMz47DQo+IC0gICAgICAjcHdt
LWNlbGxzID0gPDI+Ow0KPiArICAgICAgI3B3bS1jZWxscyA9IDwzPjsNCj4gICAgICB9Ow0KPiAN
Cj4gYmFzZS1jb21taXQ6IDBmZjQxZGYxY2IyNjhmYzY5ZTcwM2EwOGE1N2VlMTRhZTk2N2QwY2EN
Cj4gLS0NCj4gMi40Ny4yDQoNCg==

