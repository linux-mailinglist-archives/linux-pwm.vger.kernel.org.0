Return-Path: <linux-pwm+bounces-8285-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLkMGOVWuGmKcAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8285-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 20:15:49 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE729FA45
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 20:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 549633019E00
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34233C186;
	Mon, 16 Mar 2026 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BjNMI6uu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010009.outbound.protection.outlook.com [52.101.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33421DFFB;
	Mon, 16 Mar 2026 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688380; cv=fail; b=Iagud/4ROVILJsBopzpQbcTSfNBUCIQ7QrrwYOHjukyGuamToPhJXg8lwCQztrYvpSNHe5POG5XqMI7CF5Mjx3b8epwZwWf/FURfXyz8jsxICga7RUXs0+DK0SpbzaSM+R4vI6ziTg9OYfF7HsIDPsZgm/YVyvltd0yopIlRMb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688380; c=relaxed/simple;
	bh=febva99LPAVEN0wW1Cw5ljjQTBp5orKNUs8F/IPYi+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xdf1VbtmD2PiIb2F49FxF23gTIrDw/Ty2SkJKO8Aa6x/xzaNOS/Rc9hZl4dXl8PUuFblnUSYPAzXz8D7b5Q2qfwvar3Z5oM/P4d5Lm6PNhDGGCxiA5vZGgqLGpn+0WC6K2laOQG0O1O+/Izd6Qs1lENQA1arAA+iZ9B3UzJnX8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BjNMI6uu; arc=fail smtp.client-ip=52.101.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dntZmy/6i83JDrnt/q3bIRv7moR6Njjk1gSJR7n+iyAoHiSwwgjjDzs/QPg5wysDpFtK3lTjelotPXhyHG4LutMahtei/4hrKToO0KnpRzZqQqAJcft2oDPyoBr7zF2sLsHmWNtEANU/ZpmDhDOgeuyy6y4ffh5MMazdFLV5ReFe6esk86sBjb6JX4vTMkqt9tXem4ZtFEhWST0NYl2IP4xKlX/K+M/y6U7YeO1VUiUoP3QWai//X5ojR4VUA+bz0WskH50eR9QesAVRwDAv9wXAqaeaThqdpc6bsFQSSIPCLwohp/yHvAuj6pZDbSXrkwZpchTpwN0g+Ii+tOjtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=febva99LPAVEN0wW1Cw5ljjQTBp5orKNUs8F/IPYi+8=;
 b=sXQDi8z8FD6BK9jZBWINLht8UgZnk7y75NTSidhIP772JpNeg1W3Dr7ZBpuv5q0nazQkZOKhOtA19zObfuclCEwLV/78XIhrJRxjA/gWLMzCcwzhE2zLTeSxcPbDrph7UPJSCbfzdfQFMSogYBBOAwmYsGDheYVfjsf9u5XCx9cU+WHjMMoCCe0YebjzwkJzRJTYItdtmCOWUqnvK3n4Irk+Y2xsp0VDlriCUnOawOKLLJ5XUD9ADjhCWZT0RKk2rU4ZJ69mSlKb6+SeRys5sXO1afLMRqbG1S8cqcDbU6l+I89djjaExOCFoH1V9jo+rdkUkfbTIqW9j7uYmguFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=febva99LPAVEN0wW1Cw5ljjQTBp5orKNUs8F/IPYi+8=;
 b=BjNMI6uuvW4Rz4yesKU9hu8QGri0AB6RcLvjRWPFI4oJUIxZTQYMHWY+w42cGqmn37p77IgJNDRp+lffNR/4f8+4QPnXdc5h7C+MldHKrXdbmOXoo8CO3A35ISXNgxr1UPX2w9aZBoSW6zBlLwWJsP+aWF8e48Xb5o/TbJJJ6Hk=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by OS9PR01MB16375.jpnprd01.prod.outlook.com
 (2603:1096:604:2bf::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 16 Mar
 2026 19:12:49 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 19:12:39 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, William Breathitt Gray <wbg@kernel.org>, Lee
 Jones <lee@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Topic: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Index: AQHckeNxm+l5nvVDhECE0kd9r0GiYLWhc7cAgAAuuBCAD+SBUIAAOgQAgAAKtEA=
Date: Mon, 16 Mar 2026 19:12:39 +0000
Message-ID:
 <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros>
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|OS9PR01MB16375:EE_
x-ms-office365-filtering-correlation-id: cc8b2135-cb22-46d1-a2fa-08de838ffdc8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 D/lvQx+hQMRgOayx7xYe/Sg3Y6B4SdhRUVR4J28LuPjs3v+3cJVC22yI3Ol7GqZ6KIikiszB0HxXvH/83+tJPYXH+MklbmuM1vF6eAYGNMnvnevqbGtSc8DOIE13qONAzLQCB0VyaMCcDq0+H3jB8I2Ilzgpy4YshKQf6Re6DZYj2euXkRS512ZivE9SnzZ8f64aERAfMw63y8v5UuqQJpChjAY48YFy2kfMLzm5JZ1l+JLr2TcDj+Cp7T5ppsji84MooZJg709uGnVKXFwG47Q7zcq6aZcoD0tGYfneiyOpC4iIU2APLrKoTPAvt3jLyya9Sb98Q1AMrbRDoHZZQ8L9JpCV6qsO8zG9lyGuFXfTwOsIxCdyLJC7wDmPSKMZPo8iqbOxUzj3ME2BwL7CljE16+YIWuNADtIV+YPYlH0uT9hMoL7qamLXffKEMxzFzLNcvdsdsVNHWFnuuPJ4xw7zTqCSONxCAkYmjzCO+9UxXzd0m9mNPmIrv/EAOqT7VPVNCukSI7gplZgf6wHKLsroTUNrManH/hGYT+jcw6qTvs118DoFeYoJNxAFQoF5sDTHbVXCpwj/zlNPn5MLqq+PPwLzFWsg9XazQRmHBeYyUlha8R0tzC9TZeV4BfC8Z3j9bh0dLZ9pq9kRpi+zXWkzy8nNUDU0HCyUOzWF+dg7xZJoKWYVG4j60xyGdsgYEcvaQBe+0e17hWObLfuRkHr+TbtkLC9dWStVmkjqYkBiEB0uXZ++gOgC9ri2qsjSVtgE28c9bMzshMm6hvhZfS04598btLxNMQSznPgaddo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UElFWHdtRWU0QTlYeUtFUlJYR0xySXkzcVFqWERncmxQR0dxdFVhWm4yNER2?=
 =?utf-8?B?UUFaUEtEN3VYZ0tGTDh4WVpWeFpvcDJ4emxWU2R0eDBIVWZNdUNBbkNZdXAv?=
 =?utf-8?B?SzR1Uks1OU9OZ3h4enNCMTlmbUZJaWNQcm9iY1FBa2FHWVNLR1dmbjFyS1Av?=
 =?utf-8?B?eWFBYjg0R29UcFRJQXVlSTVqMnpMZzIvbGVNUG5SV3NPUHYzNTFTSjFVRkZV?=
 =?utf-8?B?THVhS3BRd080V28rc0ZLcS83cGVNTU5iUXlmUFFqejV2bDJQTVBIQ2h5ZENK?=
 =?utf-8?B?aHFIdWpNeWUxUUFiNE9WRlExSHhLWUUzMXZONk5zTjQzeGNrc2FXNGVEQ0to?=
 =?utf-8?B?RGlUWUdLT1JKSUs1SWYzM0g2cVV4VjJoM1ZKYzJQcmdDZ08zampIV3lCM3Vo?=
 =?utf-8?B?TTQ0OFU2NXp3YkdpK2JlLzAxZkoyVjZzSXRicEVpNy9reWhVbnVLU1lDR2Jj?=
 =?utf-8?B?bHhSU21aYW5hN1hHdDdQQ3lKa0dILzJtV2JwNnhMUlI5bWl4RnlmYTA3b1Zi?=
 =?utf-8?B?SVJKSDZiS1ltbWhPNVpsUTFHa0NPTDV3VVFKNS9Ocno3RDZiOWpJbTd3OGN0?=
 =?utf-8?B?K3NEazlxNmp6dkM0a0JVMzdEUUlBNW0rSkJURFhZNThVd3g4MHY4aTlyUS9W?=
 =?utf-8?B?OUlFMldBQVZtQTBxaXBvbUNXRFNJK3BWNkJqTTdQbWVidXBVNy9UVkJyWXpT?=
 =?utf-8?B?bS9xYW90TTFzNEZpa3o0WWN3KzNVYnN4TDVYemlJOVVkS0RYMWtsZ0huaVdo?=
 =?utf-8?B?K1ZCcytLRC85anY0d2UrcjkyRDNCY3BrTlVCcEt5b09KWWJsQkI2bGl6VjNQ?=
 =?utf-8?B?TCtUWUIvMVZXNm55YkFlaStUZGdpckVReExXbUNpNnFqVHRWOFk5c3ladlhI?=
 =?utf-8?B?M1BTQzk5cjAzZ3BSd0lNQU1sWC96WWdjbnFITWZSc0RZWXBiSUtqNW1yRWI3?=
 =?utf-8?B?Rm1Ka3dkdFFUNjA0UHNWNi9VN3NDVEtBQWt4bmhlaHp5VXNHR3JuZktiN0ha?=
 =?utf-8?B?RlkrRW5EdWE2YTNyWkNOb0wxSjh5Vzl1aXliZW9nc09NeFhkL2dMNWRuazlW?=
 =?utf-8?B?QzVLdDByVWlOM0kwaHcrR0ZZTnRPb1hUTC9EbFJrbUJLQVRKSUVmam5KL05I?=
 =?utf-8?B?RGxnWjVCdDVHeXFjd0lleEFVSmNESktNVFN1TjlJdEtSZ0p1WXphc0M5NGdN?=
 =?utf-8?B?NHB2QVZKUnh1Si9qYnR6T2JYVENxNHgyemtVa1Y2b1Q2NEVoTVBDcURVMnk0?=
 =?utf-8?B?eE54U0p0Y3gyZGRtd3hQcHhRRHFSRXlraTNDWS9ySjNWV3JhdnVuTVRsYUJR?=
 =?utf-8?B?T1RtdGxTVFFpOVNMaS9zYVgyR09zNWsyM2doM1JIdFAwVE1vZVRFaVFMV1VM?=
 =?utf-8?B?Wkd6a2IrNGRsUEd4RklhVzU0QnFERFJFT1ZNUHFEWk04QmFKZU5aVkRZbS9r?=
 =?utf-8?B?UXc3OTVvcFZoYW5QcDlldVl4TE16WmVnNkpwNDFWQkJvTERnMXJVV0lSV1dN?=
 =?utf-8?B?NEhaTGVEYWhzelVLRnFHY0dQZ2hYSmkrRHlmd2drNHlFL1VsTXFwakFxd0sy?=
 =?utf-8?B?WERuM2tRNXpialpZWFdRVFlRK2w2UVI5YXBzMjFmd2hvS0RaYkhXYVBUenJY?=
 =?utf-8?B?Q1NXdTZiN1RXa2hYUTZMQ1V3YVBwS3VGQUhqZU82MmJHcFBPZ01tTjZhYjc0?=
 =?utf-8?B?d0JRRVN5NW5zUEhDb3M0SGhhWXU3SmQ4S01DRFBaNDUyWnpWbXJxNHlTcmlx?=
 =?utf-8?B?eFUzcGRzc1JoSmlEYVJqTTNrSkFzYVk4NUd1ZlhEM2oyUW9vdHllT29nRFdF?=
 =?utf-8?B?RGlWRVorL0RCd3RPNlBDT1VQYzhhTmxyY28xZGpYZ3M0enZxaVNKa0dDelB2?=
 =?utf-8?B?MjB2K3hBb2kxY293N1hEWUpWamUzS2dJM05ma1FRcnpZUUh6N09NZGtRQTRk?=
 =?utf-8?B?TnRZdElzSnoyODhGeTJVRDVaazdmcGpPckRxaGMwQ0d5SzRCbzU2aGFaM2R3?=
 =?utf-8?B?T3EwckRlcU9RaWtjTzJlaXNGbVJhRDNaTnRoWm5BdmtRemh4Z0tOWEU2cW9Y?=
 =?utf-8?B?dmlycVhnMHB5Y3BUTDl3eGo4dDV4YmNqVXkxUGJuRHd5NEJqUXh2aHd5WlVo?=
 =?utf-8?B?UitsUVc5WkNwMFRiWXBiakNjUDk1Y3dHS045ZjF5bzI3U1BRVWVoTnlGMGJU?=
 =?utf-8?B?SUFRMzlhSktjV0M0K1Z2OTN2Z2pBZHE5THpZWVhwNHhaM0ZnMHY2cFdPdDVw?=
 =?utf-8?B?NUV1TXdGaUdnVXhsdUcxWHlEYkN0M21YU0hSOXd5MmIySEN5dUorQ3pWR1FC?=
 =?utf-8?B?RFpDSCthNGRncmZHdlVLZ0llaUxNeFFRZEpLTmF3T0NEd254dzR5eUNGUUU5?=
 =?utf-8?Q?wf8QngfXKqWJjJQnZ4c+rYNZBa/Y0jo64EdmA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b2135-cb22-46d1-a2fa-08de838ffdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 19:12:39.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0N/cD/oa4V/pL2sLKClVOI9K2D1qe2+HcuBTN9gFo7wTdHDsBwBbYy4oXuUnTBCx0cqkHgF+a7pC99iS44cOpLqCrxXR1BRvyWNGjLvO3TyuDNE5oFkDtOjtCDds0sah
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16375
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8285-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[TYRPR01MB15619.jpnprd01.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 75AE729FA45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50
OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDg6MjYgUE0NCj4gDQo+IEhpIENvc21pbiwNCj4gDQo+
IE9uIE1vbiwgMTYgTWFyIDIwMjYgYXQgMTY6NTIsIENvc21pbi1HYWJyaWVsIFRhbmlzbGF2DQo+
IDxjb3NtaW4tZ2FicmllbC50YW5pc2xhdi54YUByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gc3Rh
dGljIGludCByel9tdHUzX3NpYmxpbmdfaHdwd20odTMyIGh3cHdtLCB1MzIgKnNpYmxpbmdfaHdw
d20pDQo+IA0KPiBVbnVzZWQgc2libGluZ19od3B3bT8NCj4gDQo+ID4gew0KPiA+ICAgICAgICAg
aWYgKCFyel9tdHUzX2h3cHdtX2lzX3ByaW1hcnkoaHdwd20pKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gaHdwd20gLSAxOw0KPiA+DQo+ID4gICAgICAgICBpZiAocnpfbXR1M19od3B3bV9p
c19wcmltYXJ5KGh3cHdtICsgMSkpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gaHdwd20gKyAxOw0KPiA+IH0NCj4gDQo+IEdye29l
dGplLGVldGluZ31zLA0KPiANCg0KSGVsbG8gR2VlcnQuIFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhh
dC4NCg0KSXQncyBmdW5ueSBob3cgZXZlbiBhZnRlciB0cmlwbGUtY2hlY2tpbmcgdGhlIG1lc3Nh
Z2UgSSB3YXMgYWJvdXQgdG8NCnNlbmQsIEkgZGlkbid0IG5vdGljZSBpdC4NCg0KVGhpcyBzaG91
bGQgaGF2ZSBiZWVuIHdoYXQgSSBzZW50Lg0KDQpzdGF0aWMgaW50IHJ6X210dTNfc2libGluZ19o
d3B3bSh1MzIgaHdwd20sIHUzMiAqc2libGluZ19od3B3bSkNCnsNCglpZiAoIXJ6X210dTNfaHdw
d21faXNfcHJpbWFyeShod3B3bSkpIHsNCgkJKnNpYmxpbmdfaHdwd20gPSBod3B3bSAtIDE7DQoJ
CXJldHVybiAwOw0KCX0NCg0KCWlmIChyel9tdHUzX2h3cHdtX2lzX3ByaW1hcnkoaHdwd20gKyAx
KSkNCgkJcmV0dXJuIC1FSU5WQUw7DQoNCgkqc2libGluZ19od3B3bSA9IGh3cHdtICsgMTsNCg0K
CXJldHVybiAwOw0KfQ0KDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAt
LQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBp
YTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRp
b25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+
IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcw0K

