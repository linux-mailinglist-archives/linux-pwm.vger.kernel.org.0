Return-Path: <linux-pwm+bounces-7751-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A6C9821C
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 16:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B827A3435EB
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F807332EC1;
	Mon,  1 Dec 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="rlmF21AZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD372332EAE;
	Mon,  1 Dec 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604499; cv=fail; b=o+EUvn2OVfpPk6adaGxw9i6zj2dRnsFdPwxOhoW3+DA1CkYU02qxDMhz0dwSTDJgvNJvIP+6rrq8GDAFPcpmIhBzYd913AUS1dJGu3LcK1/megNnBggeR2q/fl1WyBR2OczUiiAfdlfYuG9M5087IprLB9NqpqffUUdkLgsZp5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604499; c=relaxed/simple;
	bh=MttpBy9B0b5V7O8d3vqPfs9/4oA9wEa9OLdqIX+wjUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqh3aK/vbMAmS3HZP+37ZoLXQIAhMraFQA1eNkU+Ch0yyuroLu9Bi8tk9XckjQZwH/AnRNXOlsL4d184vRBY11oi8yxq3sm4GdSEvtGmazRzKMh6MVJaLAlxngeyCEeMJSyk4tbqmZXWoja1ZM4CBmg1m3pwapdw8jCcyirKauY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=rlmF21AZ; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVWN5SiGSj5Q78VorCpqt2S2Lyd4QfRJcV28THAt7T8VPDyehwKenLo+j1aoiA1ki06k961a9N2dyJocWDhXGnkBgaZGRDk4qtnZ8rW2jT+HyDK0pRgNBsZvvUSV3Xa+FmfwAiG5344qGubwINVEk5RsBLfJeojC+i5BvtRv8pAVHCZ2eFECu1agAC+aTqU8r+yOJJrraXFrXJdg0T+z+SjgfkyQXn4edYLyfnZV7j0Z32vUlWnN6KUlaVUz468bW9EHgMOIDD84b71XN0LIE54eNQgXJCwwAKB9yeVyCNfd6m/rqgbl1tqFxvGFYtfawg2WnkZ/s+ZcdlvjVDxDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MttpBy9B0b5V7O8d3vqPfs9/4oA9wEa9OLdqIX+wjUE=;
 b=n26LCAewUafjXfWOfpxtAxH01jxDfc2iysR2hHl0/vyV6HE7V0ikqUFPGVtCDsgANJrOizYyElh6yTgdSidm6UgDlCNdkMcroF/Mc7EAxoT4Nkj40bl7VLZFOcG2Z/b9TsuvhiINgSbnusXEgUE9FPK6ip5a+IimLEotJs6wZXCrh6m8+bojEz+gtUDUn3h2/1XDuc/hSiEu2X6KtFavrFCZoDFI/Yi5OeZcXN+BAw0iDXIawsvcvYtq+cdxcrNq2lbCtoo3Fw+QCmwj+g59wHJJ0Gzh3Hs2jqcgA3zPdcHI2zXpEzWR/V2D6TcPZLytALXX21fhz0Vb++/ZWgT9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MttpBy9B0b5V7O8d3vqPfs9/4oA9wEa9OLdqIX+wjUE=;
 b=rlmF21AZq/GpCA4cxnAMUznGrG5+LhzXuXSrr7t52gnz/70U2+wAil8odiUbi5ee0zykb3OZCK7N52CDecd63506eObVErmYsWruAUNQJSGXSoD13P5vQ+ju+WuUciOFXfCOQxSn/GDy1tILJ+Yyic+A24Op2Lz/YS3IfXFvkB8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7845.jpnprd01.prod.outlook.com (2603:1096:400:182::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 15:54:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 15:54:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 0/8] Add RZ/G3E GPT support
Thread-Topic: [PATCH v3 0/8] Add RZ/G3E GPT support
Thread-Index: AQHcLJi3nBegrR4LWkun70YnsuXN4LUNUv4AgAAAToCAAAkCIA==
Date: Mon, 1 Dec 2025 15:54:51 +0000
Message-ID:
 <TY3PR01MB113467B2F302DE0DA74F0398586DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <vbqsrlqyzd2hhg3qhbpuw4h3tfigpf5vv5yfqoxyad7b5657sy@4opkalytc3kv>
 <TY3PR01MB11346A70ADEDB2367AA93433086DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346A70ADEDB2367AA93433086DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7845:EE_
x-ms-office365-filtering-correlation-id: 87b33800-e3bd-4c86-dbf0-08de30f1f6ca
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rzhsd2NMZWRsZlJNR3UvRkdZa0RRUUlkNU1PUmkxbXE4T3QxaXJDcGVnM0l6?=
 =?utf-8?B?MDJ6bHhwSFhpZ2dHSjBPQmtNRXh1Y2pQQzVnSzA3OFVVamZFZDFIYVBQYytM?=
 =?utf-8?B?cTA0NE51d2toMEQ0K0NOYy8ydFpEUXFSQU91RGJwbU5reU9LVkRhMVJLNjVm?=
 =?utf-8?B?WnNnOGpWcEhBbWtPUlZDWHl5enZXcU1JcTU1b3ZwUnFtVGRmTlNkOHN1YmlD?=
 =?utf-8?B?SVBKQmxsUUh6RTg4WUFZYXZscHBaRVZ4NTM5ZnRFSEN3akpQbnowNTVXZW1q?=
 =?utf-8?B?U29CckwvbW5lMzJqbWxzakNYL0JldjNxZXJyLy80RFpPcjBNUUtnQ2RTUXB2?=
 =?utf-8?B?eXo2YUM4ODJISXFLT2FneXEwcWphbi82MFdSbm5JNW94WVBIZGxReTRqUGxt?=
 =?utf-8?B?Qjh5MkttT2tNeE9rRHJYRkkwT3JCNDlxQ1ZUYXNpZ1kvRFQ1QVdLTHZJSitk?=
 =?utf-8?B?NU5RbjlNVTYyaDR6UVhXb09TKy94MkxBRGwwbk0ycXBQYm1Pc2JxcVpkZW5i?=
 =?utf-8?B?UUl1dXBLSndSTVJEeTJOVWZ4OXNDVG1DekhnUXhPVXBBVGJLckpMZURxd0s2?=
 =?utf-8?B?bVhuOU1lOXA4UWJzd29SNzlqMndMellPWjdUaHdNMmRPbStzeVRxaUlzUVRW?=
 =?utf-8?B?NjhEaHV2ZUVtV0pnMTFCWW1hMVNZcXFpbHkxZEhqVzI2b3NVV043RWRXSjVJ?=
 =?utf-8?B?U2V5NEMvWmxlamFiL1JCYjA3Z0hudTRITEZLNEI0MVQ5dFIyZkdxMklCMkFH?=
 =?utf-8?B?THJDRUx6cEVGSzZGK2tUcWh5OEllL1VHaHpCT1hkVHZWL2EwUUFOd1pvamxv?=
 =?utf-8?B?cDhibHA3M1hIcWg0c2R2VEo3MUNBQzJNbjJnbmR3d3VNOUx6NTJ4bWQ5QUJv?=
 =?utf-8?B?RU5yN3dQUHFYRmtZREF3YXZ6MnJNVlJVVHJLdGZSNldIVkZFQ2tWV1ZFZWpC?=
 =?utf-8?B?cXU1ZG5ONjU1ekpsalpxWTRoSVR1Q0F6MlBOV0cza0dJd20vSlo1MjZoZGdJ?=
 =?utf-8?B?Q0x1anNWT290am1XVGxSSzhwbzhVUFJKN1p4Z1FQZEF0cUFuRnBxM1lMTXpK?=
 =?utf-8?B?RjBEcDZFWlB6aTJKQ01PYkdkQVd2L2RjUlExdHU0dDhGVnpqZVZKSkJvOC9C?=
 =?utf-8?B?WllIK1dOOUhtZmFPcHpGZ3hJZmdvaWtGUmNOTVg4RDVUakN2Z2J2VERvbWtY?=
 =?utf-8?B?eEVocVRIUlZLZVZNZVFVSllOUFFjWVNDUGVRYmZMNkk2ZkNTd3JodmlIMndv?=
 =?utf-8?B?T1NwM2M2a1lBSDVYTmVzZUFDbEVOdEtVSlhYbEZEL2Nkb3lxSENwRk5GOWlQ?=
 =?utf-8?B?d3BXSjhvWEhtSW8vK2hJYm5iK0lpeEdOSEZzZlZuTFFpMGE2RlU1dnYwSFdJ?=
 =?utf-8?B?ZitRdkY4cG85WlFTaEVjMnhlSkNEV202MXQ3Sy91eUpFNXc0OEdlZ2RqNFJT?=
 =?utf-8?B?cUJQRytKR2dsc3pid2NUMjZQM1N6VjNGZ3k0MEtFQk5iZzAwQTM2aHNjT1BF?=
 =?utf-8?B?aEVCVzZxUFF1Nmw3d2RpdVdzU1d2VkZzQ3BCS2t0M2NEVUtkbExxd0EzNHNX?=
 =?utf-8?B?b0FneHFWQlA2QzNvVUxtdlB5ckFaUVNaRjJISmZoVmhYQWtiYjhMRUlKaEtv?=
 =?utf-8?B?Z3JSOGlKTERZREZLUitNVDBadUlwdktiQ1kxK0J0NE95Q0NOSTJsWUNkUTZI?=
 =?utf-8?B?RzdNdjJnVHJEY2JmNjJESmZpNDJOVDlPdjBHcDRCVGlHOWdRbWVUSTUvYzBu?=
 =?utf-8?B?RlF2WXJHbldaKzA3ZHptT2pyYWRhajZFVlREMHhvNlVyMTFZVlNYRkVmQTRr?=
 =?utf-8?B?N01ldExuWEMzWTRXV1BYUHpVdXloak1Jb1p2TnhxNXJJUU4zQkJWM28vRjcy?=
 =?utf-8?B?TlFtdGNDczFOV2hFU2V5TVRIejdwYUtkaGVKbEVLSVN5T05DQmcyRkdiZDNM?=
 =?utf-8?B?ZVJRa3JiazVFK2FMbmhxdENPaG1sY0NDM2tjQVNrWVVocnFQaVVUSnVTZ0dk?=
 =?utf-8?B?VW4vSk8vdlFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVBIL3B2eEhPR3FULzV0SzBUS0REdHdWbE1VcUFTU2kxK1NwZDZ6NG5FSnVZ?=
 =?utf-8?B?S3JQK2k5dmt6Wk5PbHVMYzZrOXF4OW1Zc2dnNGpTZlExcjNnME5oK2FxVEIr?=
 =?utf-8?B?b1dHVlliNWZXZnlUZGdoQzJ6SGVrOHF0K0phMmhLa2IxbkRDeG1zc2c5aERw?=
 =?utf-8?B?NWlwMlliVjZrbXBoa0RtVzByUHVoSWtGemtiTFVJVmxmMHQ5Nk14dnZubFZY?=
 =?utf-8?B?VW9waThoRDhTWDVrWk02bG5xODM4RFdVT2tvZks5K0lGUStzczVFMFdHb0dr?=
 =?utf-8?B?dFJVTW1EU0ZSV0xWL2xSWk9GdzdUS05KWkRGK2lBSDZoSVo3dTdGN0lDSTVQ?=
 =?utf-8?B?NUtGVHBvZUZNTENoYnVsMDRXMkdPNjR1Vnk2QjZiRUZXWVpCUUQyN0NSUGRE?=
 =?utf-8?B?Wm1pWnNwUFY5aWVmaUJhMk4wc1pxd05OR0Y0RDNHeVByTmJ4QTVxODUxRldx?=
 =?utf-8?B?WEJod1lNc0w3NUVJRWdKVDNnYm1kamo3UTkwcFVEY3M0RjhLREFERVdWSUlJ?=
 =?utf-8?B?dDA1eURDcXJYTUJoMkwyLzB0cERLZlFHSFM1UGY0UExCMXd1UUorem5PbFNV?=
 =?utf-8?B?TEhMYzR3bnh4VWtHV0tBZk5odEs3dlhWWVQzRmVzU2hybGdDcklCVmpnenkx?=
 =?utf-8?B?UFhsTjNzZkVIaFhLTHozTG1pTUhJVzRkaHFqdHRDcnpveWNibVMvU1NLL2J2?=
 =?utf-8?B?Vk5GcjdLMzFoQWdYeGlpRXVmcjh0ek1pZGxNT0FmNlRBZUZSYkFZR2dpQnRC?=
 =?utf-8?B?RnJiL0NyQ09NZkd4UHRuNWkyTmFJY2FyaXZ2bjMvR3k5RVRSeUJ0SFBUbzNF?=
 =?utf-8?B?YTJ6c2tGSnBlcHNGTDFwRU5CR2ZuWis4aUFlc080N0E4UmJSSE9wUlliUmJl?=
 =?utf-8?B?SGE0NzJoZ296cC9XcGhpd1ZTM1dYN0xlZkNlVHNDS1dndnVsODdxVTlDZDBU?=
 =?utf-8?B?bEZGUzVZeU05UXhHMEgvQnF3WnlvVFVOVExmcndVaVFsNXRLb1I4VEZzbVhE?=
 =?utf-8?B?cHhhd3JWUHJzWXVlcTZ0ajVUTjMrbk54ak5aY1NBR3N6YzlqdXN4MlFrTGRD?=
 =?utf-8?B?RFA3b3dzZTZya2xrbFlSSzExaGp1WHVJNnkzcmZHS1hDa2lUYzBOZnVQMWJu?=
 =?utf-8?B?dzFQNVBkYlpPV3VXS08yZTFrdHdxRk5nWE9pcGs1NU1wKzFoVjRqWW9VS1lK?=
 =?utf-8?B?aWpOYmhaNFpkNXJQc25Ba0x1Vmxvc2Q4OXpFSUdBVEFBLzQ0dStteFRRT2dO?=
 =?utf-8?B?aU95QXduUHJNSUVRYmlja214Szd3VzYzd05nczNZNXM5MnNMdGo3MGcvOHox?=
 =?utf-8?B?RmpWM2NTK3NtNS91YmVROHV6WGhJTzVVRjkzSVZvYXhlaVEwSUpqY1dUcVRo?=
 =?utf-8?B?cHVjUzN5WTRxeEVndnVCLzBZeGJrMG1xQklQTWt0UnFNNUxRRHB0a05DMTFJ?=
 =?utf-8?B?bXdGMFZZbmVjcWhFQVV1Q3pQa0E5YW1Yb1ZuTHBYVit5MkpmZDhXTXZoS0Ry?=
 =?utf-8?B?VFhQYytLV3I2ZWUwUHQwY21VTDlEQ1lXZnNKc3BzWHFlVlgyN3RaRG8xMndl?=
 =?utf-8?B?SmxMMU1oSm1vL2J1QTdoSE9NRzdjVXAzbTRJQ1o1d3lkZFFremN2MEN3ZnhN?=
 =?utf-8?B?RmdXQ0h6QnA2R1gzK2NhUTNzK0tTWVVCR0JFdUIzSEVYN1ZTRkMzcGdrcUlr?=
 =?utf-8?B?Zy9DME5HZVlaa3BJNUtrZ1NCK2MrVmlmWDNqMWpSbGlSd2hVQnJ3RVk1ZEdy?=
 =?utf-8?B?b3NKZ0w2TG9VMEtEUnNmcldYTEIzOTlQaTlOOGZ6SVdONlF3ZWwrOUFNNEx6?=
 =?utf-8?B?Q0QxRTlmbWxFOGpoUTJEL2thVVRCSUVmV2Jod1hScHJUeVpTQ2VMZ3R5a2My?=
 =?utf-8?B?TDEvbzNBUEhtNnNubC9nQUdwbk9HN2paWjdwNURyWTZUMThlK0lQRVNsRVhB?=
 =?utf-8?B?VFBuS2UvYy9yRUVoU1dNZXoxNTFPcU9mNWl1dDJDTUhNRGorcEdiWUltNzBu?=
 =?utf-8?B?c0wwMHFqZmZhdmdhWWRQSVV0b3hGWjJGenJYclBZZUk2UHBsQmprdG84a1Q3?=
 =?utf-8?B?enhlRk53bnpiaG01eUk1L1YvY09QRDE0SE85eWJmU0dpR29DTGVmbFloWmJD?=
 =?utf-8?B?ODdMZ3o1dHQ1cmZyek9IcmdQdWtJM3NuejhQQml3Y295Y1c1Sk1QSXZMMmJS?=
 =?utf-8?B?Y0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b33800-e3bd-4c86-dbf0-08de30f1f6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 15:54:51.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qNqP1K73Dr+XKoRg01jg2UT11JvXCaLWqOpp4tUnuP8AOnL2BnDJr9NCydC7Fby3jqx7aTHHXM2DFx3Ayq3pQh7ULDywCWUuECCFfXg+Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7845

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMNCj4gU2Vu
dDogMDEgRGVjZW1iZXIgMjAyNSAxNTo1MQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYzIDAvOF0g
QWRkIFJaL0czRSBHUFQgc3VwcG9ydA0KPiANCj4gSGkgVXdlLA0KPiANCj4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5la0Br
ZXJuZWwub3JnPg0KPiA+IFNlbnQ6IDAxIERlY2VtYmVyIDIwMjUgMTU6MjENCj4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDAvOF0gQWRkIFJaL0czRSBHUFQgc3VwcG9ydA0KPiA+DQo+ID4gSGVs
bG8gQmlqdSwNCj4gPg0KPiA+IE9uIFR1ZSwgU2VwIDIzLCAyMDI1IGF0IDAzOjQ1OjA0UE0gKzAx
MDAsIEJpanUgd3JvdGU6DQo+ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gQWRkIFJaL0czRSBHUFQgc3VwcG9ydC4gSXQgaGFzIG11
bHRpcGxlIGNsb2NrcyBhbmQgcmVzZXRzIGNvbXBhcmVkDQo+ID4gPiB0byBSWi9HMkwuIEFsc28g
cHJlc2NhbGUgZmllbGQgd2lkdGggYW5kIGZhY3RvciBmb3IgY2FsY3VsYXRpbmcNCj4gPiA+IHBy
ZXNjYWxlIGFyZSBkaWZmZXJlbnQuDQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZGVw
ZW5kIHVwb25bMV0NCj4gPiA+DQo+ID4gPiBbMV0NCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI1MDkxNTE2MzYzNy4zNTcyLTEtYmlqdS5kYXMuanpAYnAucmVuDQo+ID4gPiBl
cw0KPiA+ID4gYXMuY29tLw0KPiA+ID4NCj4gPiA+IHYyLT52MzoNCj4gPiA+ICAqIEFkZGVkIFJi
IHRhZyBmcm9tIFJvYiBmb3IgYmluZGluZ3MgcGF0Y2gNCj4gPiA+ICAqIERyb3BwZWQgd2F2ZSBm
b3JtIGNhbGxiYWNrIGNvbnZlcnNpb24gZnJvbSB0aGlzIHBhdGNoIHNlcmllcyBhcw0KPiA+ID4g
ICAgaXQgaXMgY292ZXJlZCBpbiBhbm90aGVyIHNlcmllc1sxXQ0KPiA+ID4gICogQWRkZWQgc3Vz
cGVuZC9yZXN1bWUgc3VwcG9ydC4NCj4gPiA+IHYxLT52MjoNCj4gPiA+ICAqIENyZWF0ZWQgc2Vw
YXJhdGUgZG9jdW1lbnQgZm9yIFJaL0czRSBHUFQuDQo+ID4gPiAgKiBVcGRhdGVkIGNvbW1pdCBo
ZWFkZXIgYW5kIGRlc2NyaXB0aW9uIGZvciBiaW5kaW5nIHBhdGNoLg0KPiA+ID4gICogQWRkZWQg
d2F2ZWZvcm0gY2FsbGJhY2sgY29udmVyc2lvbiB0byB0aGlzIHNlcmllcy4NCj4gPiA+ICAqIENv
bGxlY3RlZCB0YWcuDQo+ID4gPiAgKiBBZGRlZCBsaW5rIHRvIGhhcmR3YXJlIG1hbnVhbA0KPiA+
ID4gICogVXBkYXRlZCBsaW1pdGF0aW9uIHNlY3Rpb24gaW4gZHJpdmVyIHBhdGNoLg0KPiA+ID4N
Cj4gPiA+IEJpanUgRGFzICg4KToNCj4gPiA+ICAgZHQtYmluZGluZ3M6IHB3bTogRG9jdW1lbnQg
UlovRzNFIEdQVCBzdXBwb3J0DQo+ID4gPiAgIHB3bTogcnpnMmwtZ3B0OiBBZGQgaW5mbyB2YXJp
YWJsZSB0byBzdHJ1Y3QgcnpnMmxfZ3B0X2NoaXANCj4gPiA+ICAgcHdtOiByemcybC1ncHQ6IEFk
ZCBwcmVzY2FsZV9wb3dfb2ZfdHdvX211bHRfZmFjdG9yIHZhcmlhYmxlIHRvIHN0cnVjdA0KPiA+
ID4gICAgIHJ6ZzJsX2dwdF9pbmZvDQo+ID4gPiAgIHB3bTogcnpnMmwtZ3B0OiBBZGQgY2FsY3Vs
YXRlX3ByZXNjYWxlKCkgY2FsbGJhY2sgdG8gc3RydWN0DQo+ID4gPiAgICAgcnpnMmxfZ3B0X2lu
Zm8NCj4gPiA+ICAgcHdtOiByemcybC1ncHQ6IEFkZCBSWi9HM0Ugc3VwcG9ydA0KPiA+ID4gICBw
d206IHJ6ZzJsLWdwdDogQWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQNCj4gPiA+ICAgYXJtNjQ6
IGR0czogcmVuZXNhczogcjlhMDlnMDQ3OiBBZGQgR1BUIG5vZGVzDQo+ID4gPiAgIGFybTY0OiBk
dHM6IHJlbmVzYXM6IHI5YTA5ZzA0N2U1Ny1zbWFyYzogRW5hYmxlIEdQVCBvbiBjYXJyaWVyDQo+
ID4gPiBib2FyZA0KPiA+ID4NCj4gPiA+ICAuLi4vYmluZGluZ3MvcHdtL3JlbmVzYXMscnpnM2Ut
Z3B0LnlhbWwgICAgICAgfCAzMjMgKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9yZW5lc2FzL3I5YTA5ZzA0Ny5kdHNpICAgIHwgMTg0ICsrKysrKysrKysNCj4g
PiA+ICAuLi4vYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwNDdlNTctc21hcmMuZHRzICAgfCAgMTMg
Kw0KPiA+ID4gIGRyaXZlcnMvcHdtL3B3bS1yemcybC1ncHQuYyAgICAgICAgICAgICAgICAgICB8
IDIwOSArKysrKysrKysrLS0NCj4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDcwNCBpbnNlcnRpb25z
KCspLCAyNSBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+ID4gPiAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9yZW5lc2FzLHJ6ZzNlLWdwdC55YW1sDQo+ID4g
Pg0KPiA+ID4NCj4gPiA+IGJhc2UtY29tbWl0OiBiZjI2MDJhM2NiMjM4MWZiMWEwNGJmMWMzOWEy
OTA1MThkMjUzOGQxDQo+ID4NCj4gPiBJIGRvbid0IGtub3cgd2hhdCB5b3UgZGlkIGhlcmUsIGJ1
dCBhcHBseWluZyB5b3VyIHNlcmllcyBkb2Vzbid0IHdvcms6DQo+ID4NCj4gPiAJdXdlQG1vbm9j
ZXJvczp+L2dzcmMvbGludXgkIGI0IGFtIC0zIDIwMjUwOTIzMTQ0NTI0LjE5MTg5Mi0xLWJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tDQo+ID4gCUFuYWx5emluZyAxOSBtZXNzYWdlcyBpbiB0aGUg
dGhyZWFkDQo+ID4gCUFuYWx5emluZyAyNyBjb2RlLXJldmlldyBtZXNzYWdlcw0KPiA+IAlDaGVj
a2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uDQo+
ID4gCS0tLQ0KPiA+IAkgIOKclyBbUEFUQ0ggdjMgMS84XSBkdC1iaW5kaW5nczogcHdtOiBEb2N1
bWVudCBSWi9HM0UgR1BUIHN1cHBvcnQNCj4gPiAJICDinJcgW1BBVENIIHYzIDIvOF0gcHdtOiBy
emcybC1ncHQ6IEFkZCBpbmZvIHZhcmlhYmxlIHRvIHN0cnVjdCByemcybF9ncHRfY2hpcA0KPiA+
IAkgIOKclyBbUEFUQ0ggdjMgMy84XSBwd206IHJ6ZzJsLWdwdDogQWRkDQo+ID4gcHJlc2NhbGVf
cG93X29mX3R3b19tdWx0X2ZhY3RvciB2YXJpYWJsZSB0byBzdHJ1Y3QgcnpnMmxfZ3B0X2luZm8N
Cj4gPiAJICDinJcgW1BBVENIIHYzIDQvOF0gcHdtOiByemcybC1ncHQ6IEFkZCBjYWxjdWxhdGVf
cHJlc2NhbGUoKSBjYWxsYmFjayB0byBzdHJ1Y3QgcnpnMmxfZ3B0X2luZm8NCj4gPiAJICDinJcg
W1BBVENIIHYzIDUvOF0gcHdtOiByemcybC1ncHQ6IEFkZCBSWi9HM0Ugc3VwcG9ydA0KPiA+IAkg
IOKclyBbUEFUQ0ggdjMgNi84XSBwd206IHJ6ZzJsLWdwdDogQWRkIHN1c3BlbmQvcmVzdW1lIHN1
cHBvcnQNCj4gPiAJICDinJcgW1BBVENIIHYzIDcvOF0gYXJtNjQ6IGR0czogcmVuZXNhczogcjlh
MDlnMDQ3OiBBZGQgR1BUIG5vZGVzDQo+ID4gCSAgICArIFJldmlld2VkLWJ5OiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+IAkgIOKclyBbUEFUQ0ggdjMg
OC84XSBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOWcwNDdlNTctc21hcmM6IEVuYWJsZSBHUFQg
b24gY2FycmllciBib2FyZA0KPiA+IAkgIC0tLQ0KPiA+IAkgIOKclyBCQURTSUc6IERLSU0vZ21h
aWwuY29tDQo+ID4gCS0tLQ0KPiA+IAlUb3RhbCBwYXRjaGVzOiA4DQo+ID4gCVByZXBhcmluZyBm
YWtlLWFtIGZvciB2MzogQWRkIFJaL0czRSBHUFQgc3VwcG9ydA0KPiA+IAlFUlJPUjogQ291bGQg
bm90IGZha2UtYW0gdmVyc2lvbiB2Mw0KPiA+IAktLS0NCj4gPiAJQ292ZXI6IC4vdjNfMjAyNTA5
MjNfYmlqdV9kYXNfYXVfYWRkX3J6X2czZV9ncHRfc3VwcG9ydC5jb3Zlcg0KPiA+IAkgTGluazog
aHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjUwOTIzMTQ0NTI0LjE5MTg5Mi0xLWJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tDQo+ID4gCSBCYXNlOiB1c2luZyBzcGVjaWZpZWQgYmFzZS1jb21t
aXQgYmYyNjAyYTNjYjIzODFmYjFhMDRiZjFjMzlhMjkwNTE4ZDI1MzhkMQ0KPiA+IAkgICAgICAg
Z2l0IGNoZWNrb3V0IC1iIHYzXzIwMjUwOTIzX2JpanVfZGFzX2F1X2dtYWlsX2NvbQ0KPiA+IGJm
MjYwMmEzY2IyMzgxZmIxYTA0YmYxYzM5YTI5MDUxOGQyNTM4ZDENCj4gPiAJICAgICAgIGdpdCBh
bSAtMyAuL3YzXzIwMjUwOTIzX2JpanVfZGFzX2F1X2FkZF9yel9nM2VfZ3B0X3N1cHBvcnQubWJ4
DQo+ID4NCj4gPiAJdXdlQG1vbm9jZXJvczp+L2dzcmMvbGludXgkIGdpdCBjaGVja291dCBiZjI2
MDJhM2NiMjM4MWZiMWEwNGJmMWMzOWEyOTA1MThkMjUzOGQxDQo+ID4gCVByZXZpb3VzIEhFQUQg
cG9zaXRpb24gd2FzIC4uLg0KPiA+IAlIRUFEIGlzIG5vdyBhdCBiZjI2MDJhM2NiMjMgQWRkIGxp
bnV4LW5leHQgc3BlY2lmaWMgZmlsZXMgZm9yDQo+ID4gMjAyNTA5MjINCj4gPg0KPiA+IAl1d2VA
bW9ub2Nlcm9zOn4vZ3NyYy9saW51eCQgZ2l0IGFtIC0zIC4vdjNfMjAyNTA5MjNfYmlqdV9kYXNf
YXVfYWRkX3J6X2czZV9ncHRfc3VwcG9ydC5tYngNCj4gPiAJQXBwbHlpbmc6IGR0LWJpbmRpbmdz
OiBwd206IERvY3VtZW50IFJaL0czRSBHUFQgc3VwcG9ydA0KPiA+IAlBcHBseWluZzogcHdtOiBy
emcybC1ncHQ6IEFkZCBpbmZvIHZhcmlhYmxlIHRvIHN0cnVjdCByemcybF9ncHRfY2hpcA0KPiA+
IAllcnJvcjogc2hhMSBpbmZvcm1hdGlvbiBpcyBsYWNraW5nIG9yIHVzZWxlc3MgKGRyaXZlcnMv
cHdtL3B3bS1yemcybC1ncHQuYykuDQo+ID4gCWVycm9yOiBjb3VsZCBub3QgYnVpbGQgZmFrZSBh
bmNlc3Rvcg0KPiA+IAlQYXRjaCBmYWlsZWQgYXQgMDAwMiBwd206IHJ6ZzJsLWdwdDogQWRkIGlu
Zm8gdmFyaWFibGUgdG8gc3RydWN0IHJ6ZzJsX2dwdF9jaGlwDQo+ID4gCWhpbnQ6IFVzZSAnZ2l0
IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoPWRpZmYnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+
ID4gCWhpbnQ6IFdoZW4geW91IGhhdmUgcmVzb2x2ZWQgdGhpcyBwcm9ibGVtLCBydW4gImdpdCBh
bSAtLWNvbnRpbnVlIi4NCj4gPiAJaGludDogSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0
Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4gPiAJaGludDogVG8gcmVzdG9yZSB0
aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFib3J0
Ii4NCj4gPiAJaGludDogRGlzYWJsZSB0aGlzIG1lc3NhZ2Ugd2l0aCAiZ2l0IGNvbmZpZyBhZHZp
Y2UubWVyZ2VDb25mbGljdCBmYWxzZSINCj4gPg0KPiA+IEkgZG9uJ3QgZmVlbCBsaWtlIGRlYnVn
Z2luZyB0aGF0LCB3aGljaCB1bmZvcnR1bmF0ZWx5IG1lYW5zIEkgY2Fubm90DQo+ID4gcHJvdmlk
ZSB5b3UgYSBkaWZmIG9uIHRvcCBvZiB5b3VyIHRyZWUgdG8gZXhwbGFpbiBteSBkb3VidHMgYWJv
dXQgdGhlDQo+ID4gcmVzdW1lIGNhbGxiYWNrLiA6LSgNCj4gDQo+IA0KPiBUaGUgZGVwZW5kZW5j
aWVzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIGFyZSBjaGFuZ2VkIG5vdyBkdWUgdG8gWzFdDQo+IA0K
PiBTaGFsbCBJIHNlbmQgVjQgb24gdG9wIG9mDQo+IA0KPiBbMl0NCj4gDQo+IG9yDQo+IA0KPiBN
ZXJnZSBbMl0gd2l0aCB0aGlzIHNlcmllcyBhbmQgc2VuZCBWND8/DQo+IA0KPiANCj4gWzFdIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgt
bmV4dC5naXQvY29tbWl0Lz9oPW5leHQtDQo+IDIwMjUxMjAxJmlkPWZhZTAwZWE5ZjAwMzY3Nzcx
MDAzYWNlNzhmMjk1NDlkZWFkNThmYzcNCj4gDQo+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNTExMjgxMDM0MzEuMTZNZXJnZTE1OTEtMS1iaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbS8NCg0KQ29ycmVjdGVkIHRoZSBsaW5rLg0KDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjUxMTI4MTAzNDMxLjE2MTU5MS0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Lw0KDQpDaGVlcnMsDQpCaWp1DQo=

