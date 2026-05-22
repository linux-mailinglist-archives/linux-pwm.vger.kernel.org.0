Return-Path: <linux-pwm+bounces-9076-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHxRFpgBEGqLSQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9076-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 09:11:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F75AFDA0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 09:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0AF5300E178
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC2382F1E;
	Fri, 22 May 2026 07:02:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240F3438A2;
	Fri, 22 May 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433361; cv=fail; b=DLktLvXAA/LRT0yq6qeWjpZfJbv1RnxZAlJ2SYGS6vX2b84FjLHsOLgJb8m/wIobfXLHyirDOUNVXFN99j14vngvP8uoYldjRnU/va8IZ2v4zZBpx4PalKP2Jhc+RhqMq0Br37iKyEOsO9IvJCmMgKLteNFnCI3+MUYHt5DUSWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433361; c=relaxed/simple;
	bh=7rzg8TpAHWg7cIZ9qyH3c3x4sHXgrNC+3tiN9KFNW6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MA1xNbm2kV87Ewf5Lxpcw4eA07Gz4bL4o8D06Gn3DZ3rI82RVJFYeUJy27yaagSRkHoeAmODPJnXkt/qhn2H5g93jj07r9+JwKMwiNMWLkKKZcn1yoitqn+ewZfLKfCzTIgJjl7HqQ/2wylqF9jjIaKCi+PEpgrww0LgZDKHWnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfd3OeZe2ICuuFuX4Di4WxO6PLx5lChqe4drEYEhQfwk86Wv4RfohkHuDEzJyLcINl6huxBWIzv8nhzJT/jaRh1oVr+dU/YdAr2X8abIYdZHv6mwCUGzarQ86n5P5zRa1rez7egEBPmwBYXtFWpE6Mpha+E98XzmJiUYxk0u8Q3GCw/RO1wTybfOcK4pLivwscajcpaXfmiskjEbUvEE0Mz43aFZOYNRWDaDUkIUiMx5gTCNmJw3ddhb8zzy2j1VoFnpqXDdSHJ2oj4J3ozajuuaMtu04MS9xAmZoVLgWl/S/KroCOYTnk/jKzPNT89sZy7RwFrmdDWp8tgNkcimxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rzg8TpAHWg7cIZ9qyH3c3x4sHXgrNC+3tiN9KFNW6k=;
 b=g38fqaBqIilEoSqPWxhRcS6ithYGKTXJcI3eseENringF3RYHI8c4z9Z/AMgSpblyJDnM13rWPJshMNn5Ol1Xrmr33Heo2n6Wh88BYZikhbjKCyqiXh12TtX5kc9geT//etBobp8AAYDcdVQQg37pfjRE/jPC75V/9ZNA+sCFUs4RI7xuq2ceW1VWWsvVrJhvSIh2Ysnd4hELyfjgxhk1PSxQdX7rohuy7UlVK0TSEcflHJlGPqtIz5mPSIp4S0/qNXBhoRXq5gFtASvAP/Sn2s3Rr5vIrssB4HybI1zQJ/BLjxG0TxvX2HH+jtBBH1In9e71GLJTYa5VpSLPl7L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1340.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:47:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.21.0048.016; Fri, 22 May 2026 06:47:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Changhuang
 Liang <changhuang.liang@starfivetech.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v18 2/3] riscv: dts: starfive: Correct pwm nodes
Thread-Topic: [PATCH v18 2/3] riscv: dts: starfive: Correct pwm nodes
Thread-Index: AQHc5C5T9NgT6hO6HEiFtrligTX8arYPD9IAgAqViHA=
Date: Fri, 22 May 2026 06:47:30 +0000
Message-ID:
 <ZQ2PR01MB1307EC9C21268E1030AA168EE60F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
 <20260515054723.25024-3-hal.feng@starfivetech.com>
 <20260515-dandruff-outpour-7b3b6b5480db@spud>
In-Reply-To: <20260515-dandruff-outpour-7b3b6b5480db@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1340:EE_
x-ms-office365-filtering-correlation-id: ea7b53f8-51d1-48d6-367f-08deb7cdfecf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|4143699003|3023799007;
x-microsoft-antispam-message-info:
 5JkXtA4diRyTbZ7ZbozQV6EJaWHdlob9krJBmPw8lc76qxO5AsjQyC0itxV/BeAKr+22xD64nkTTF0aNUYdFwjgpeXb548J5zRpM7QI9g23sHz4Cz04ob/QH07VgD9RBPHMrTZm0jJus7+PtKJAKq1gDXu8CGWuTqQT6mD1mcYWJNKM6p5wjFT2Z1E8uLWycG/iBXq8kbSu1vbo7qcz/f7n/vyt2dWDpvYp/e67ImO90YzPJu5U0WXIUmBoeJ6N5eCVI+JKJteyE/zpMAHhVPEnD26GZ3nP/mI2xCL4EcxMynHxXHYBU0SIqvMKr8zXupk49tBX8La2DwGR2C3pnAeqXTO6qklMO0cBfC77vtmC1qHTUekOi99wwujH9D+4Ul/7S+y0K4SsqeaRArzoFvw7HJ8HYyO0tR4h95ZT+KsQBt1pJBePa9ZXBKP/sE+po4KZxz754Bk7Zetr7Fdh2bm90QVf/bzpE6n/O9l3HkCTLK53LQhS8tirgvTdcVB8uNb2zCYeNTSmJ0NOH/08W0JqcO/r3OJlZGJNIEpBgm2DLuo5adfrPIJ/Qw9yAClp1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(4143699003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVVYcURzLzlEdjV4VEErU1BKbGszeHFtMGMvRkJDTTVyOTllN0RML2dVc0Nx?=
 =?utf-8?B?dlVjb3lSNVcrcTluam9EUlF1T2FEVGs4NDhBOW0xMmt0NjdHK0phc25Qb0tY?=
 =?utf-8?B?VGlENERiTGFuNitKbExEdTJlMFh2NEVYcHF0QTJwNEY5MFNxWEJEb0owY2lq?=
 =?utf-8?B?dHgzVHQzbDNtbGNoSlhLaldBbStiMDFmQ0ZqN1A0Qkc0MmFhWHZpV1hHVVBP?=
 =?utf-8?B?bDdrYmcvczBRUjloUW94UDB5ZkdjZkIvNUtBcnhXOENFZVk1NGR2SWx5VGRo?=
 =?utf-8?B?anhiaExib1BqSkdZcmlBdFMwQmNhbGJQcGY1ZFZmM0psNTFSOWhhKzJuUWNi?=
 =?utf-8?B?WUdwZ2pKTmV4czU3am40VU4zUWdnS0IwYmc1ZTRvNzlVdStZLzJlSVhCNW9m?=
 =?utf-8?B?dmlUejNzaVpWa0xaODB3MEVoYUVtdjZWRmxGWHYxemJoMWJOV2lweU1VQVha?=
 =?utf-8?B?S0xoUWp5T3pXeG45S0pXV2s2L0Y0YU5mejBLQk9zNGlPTU4vU0xrSU81MTd3?=
 =?utf-8?B?Qmt4MmVTdnQ2Q3p2bjlleXlHVHllbVNyT1RtSjF5WkZHaEdYTGJCcFRqVDVR?=
 =?utf-8?B?aG1EM1Jndi9peS9wNzYzNlhOcGpJL1ZKZ0NnS3AxTkhtYVlMUVJvMzdvdXlr?=
 =?utf-8?B?aCtSK1RiYTIxNitpUDk3MmRvTVYwYmNyZWkvc2ozUWQ1Zy9iRHVZWjB6cUNj?=
 =?utf-8?B?YWMyK2dWUjlvNHgxT3BUS2JwNzNqeFR3Ni9ZYmE0cnpyOUU1UUw5VEM4ZTJL?=
 =?utf-8?B?MnlKY0pJMTlxaG1xOEpESmx6Y1F6YkViT0tvWE43VmwvUDgrempaQ1hvbU1k?=
 =?utf-8?B?Z00yZDBWc2FORnNoTHJldkFnY2tjR09yUVlTTE9uNkpEbzRrdmF0UmhmaWw0?=
 =?utf-8?B?blNjTkVrN2t1K1ZNS3NjdmhoRFQzWW9oZ2FMTTdFamlBR0pJQ09kQjBIL0ZX?=
 =?utf-8?B?by9vbVlzT3dlZTRTeFQ5aEFjZUtvaWlhcnlyTG92NmhDejJIMUhLL2poQ0d0?=
 =?utf-8?B?NGhIek9BRnFRclhWVjdzUmF6SlRKeWJWVXYzM1QxQU5KcitJNTFOMXRTQTl5?=
 =?utf-8?B?Q3B2MTg4QWNqTzBheTZkL2kzZUtETTNJUHhtejdMaWllUjcvaW8rMW9veGRx?=
 =?utf-8?B?dFBXWlFnWEw4bkhaWGNtdlNlZVE4NmVnSWIzOUJTcVNkL0FGTTZ3eitRTXkx?=
 =?utf-8?B?OVllS3pJckdnMnlSajhiV2QyWmRDWmp6RklhZzREWGRnSGNnb0s4aURYWTdE?=
 =?utf-8?B?Yk9BdWhzeFkrZVJSTXNvRTdiZTd2WitxV3pRY2k1eDhxc1NsdThFUG5VRjk1?=
 =?utf-8?B?dEQ0Snk3c216VElhcXR1Qkc4MlpYRXJuRGg1MG9qbWlHc2MzR1NHSFZkeVZt?=
 =?utf-8?B?L1Y3U0tiV2xYN05BdFFkNE50ZC96NW0rTTc4aFNQakJQQkZlMnlCbmdnWStj?=
 =?utf-8?B?WitqQlIxc0ZURWdua2hvNmgyWmg1UnNSNk9yNHpLV2ZzYi9RL2lRWVVLOEdi?=
 =?utf-8?B?bk1lY2tjUm5Od1EvWVhyOEhpTFEycW9pYXNhcnFhRHExL2dDeGJwYUNmOFEr?=
 =?utf-8?B?WmlUdEhiU1lRMUdzWlcrWEkxWjJHc2l3Y01RcklyMXV0dVk1SVl3RTZFejU2?=
 =?utf-8?B?bkxUaGZnUTBiVldCMTBLSjlQd3RwbU9veW16VjFxTXhPc3VZMXNpTUI1bEhE?=
 =?utf-8?B?cFlDV2hmbTZodTE1Y21OY3BvT0dsRWtDb0hPWWdjNEZ4bnRnMTVzbnJNSlZS?=
 =?utf-8?B?MmpLaGlEbmtkTGVIM3o5Sy85ei9lTXFyUTgzOHQwTFlCUkZUeFdKZDQwTHVy?=
 =?utf-8?B?cGVCVVdWV3p2V1k1N3I0a2syU0FZMUs4eW5NYkVSajJhZWJZSzhPUm5wOFky?=
 =?utf-8?B?c1JiUW5NQkh6b1grNlZhMnVXSVh2d0pieXp3RTVLZlFHay9DQisxYnlPSU1v?=
 =?utf-8?B?Qk9XWW8xZlRxUnN6Y1d3VG1NRkVVcFcvRzFnSGc3ZmNVbCtlSVl6K1VxNWh4?=
 =?utf-8?B?aUFTMlZzUG1wV3EyL2J2TEc4WjRSNHlVdS96ZkxmODdHLytNVWE0cHRnRGI0?=
 =?utf-8?B?M0hsNDRsdTVBdktmU1ZuaUU4Y21DaDI5aXR1RHgrM05QakQwNW1OaDJPek5W?=
 =?utf-8?B?UlpudExjTUxTN1JrOFFja1BxckM0T2J5Zld0WklDNm5leTNXellZSTE5ekdw?=
 =?utf-8?B?N013ZW01MXdoU0JydzliZG1pblpqVTUvcStPYndmQUZ0K1krVDREZjlkVW9L?=
 =?utf-8?B?QkdpMllQNlQwYjhnaysvdmtpRTR3MGdXT3U2eWREdVVDREExL2RXUGt6NVhi?=
 =?utf-8?B?WFhwT0U4cHlaenJiek5xK1hUWC91Z1hWTDdqeFFHMDIvdkl5Q1A2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7b53f8-51d1-48d6-367f-08deb7cdfecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:47:30.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDI1gT3eL7smlkR5hon2WWjGBTKB59Gilc7uvX/Oh0i5Z27N401aaUYBdZmNcNPO3TbtyskTE0isVbReLvSjmXgGNAa+Wc1Zv8T1n1AleYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1340
X-Spamd-Result: default: False [4.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9076-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.983];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.190.110.0:email,starfivetech.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,0.190.149.16:email]
X-Rspamd-Queue-Id: E93F75AFDA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiAyNi4wNS4xNSAyMToxMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBGcmksIE1heSAx
NSwgMjAyNiBhdCAwMTo0NzoyMVBNICswODAwLCBIYWwgRmVuZyB3cm90ZToNCj4gPiBFYWNoIG9m
IHRoZSBTdGFyRml2ZSBKSDcxMDAvSkg3MTEwIFNvQ3MgaGFzIDggT3BlbkNvcmVzIFBUQyBJUCBj
b3Jlcy4NCj4gPiBPbmUgT3BlbkNvcmVzIFBUQyBJUCBjb3JlIGNhbiBvdXRwdXQgb25lIFBXTSBj
aGFubmVsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAt
Y29tbW9uLmR0c2kgICAgICB8IDI4ICsrKysrKy0tDQo+ID4gIGFyY2gvcmlzY3YvYm9vdC9kdHMv
c3RhcmZpdmUvamg3MTAwLmR0c2kgICAgICB8IDY5ICsrKysrKysrKysrKysrKysrKy0NCj4gPiAg
Li4uL2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1jb21tb24uZHRzaSAgICAgIHwgMjcgKysrKysr
LS0NCj4gPiAgLi4uL2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1taWxrdi1tYXJzLmR0cyAgIHwg
IDYgKy0NCj4gPiAgLi4uL2R0cy9zdGFyZml2ZS9qaDcxMTAtbWlsa3YtbWFyc2NtLmR0c2kgICAg
IHwgIDYgKy0NCj4gPiAgLi4uL2R0cy9zdGFyZml2ZS9qaDcxMTAtcGluZTY0LXN0YXI2NC5kdHMg
ICAgIHwgIDYgKy0NCj4gPiAgLi4uL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItbGl0ZS5k
dHNpICAgIHwgIDYgKy0NCj4gPiAgLi4uL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRz
aSAgICAgICAgIHwgIDYgKy0NCj4gPiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcx
MTAuZHRzaSAgICAgIHwgNjkgKysrKysrKysrKysrKysrKysrLQ0KPiA+ICA5IGZpbGVzIGNoYW5n
ZWQsIDIwMCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC1jb21tb24uZHRzaQ0KPiA+
IGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAtY29tbW9uLmR0c2kNCj4gPiBp
bmRleCBhZTFhNmFlYjBhZWEuLjg1MTA2NTQ1MDkwZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC1jb21tb24uZHRzaQ0KPiA+ICsrKyBiL2FyY2gv
cmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTAwLWNvbW1vbi5kdHNpDQo+ID4gQEAgLTE5OSwx
MyArMTk5LDIzIEBAIEdQT19JMkMyX1BBRF9TREFfT0VOLA0KPiA+ICAJCX07DQo+ID4gIAl9Ow0K
PiA+DQo+ID4gLQlwd21fcGluczogcHdtLTAgew0KPiA+IC0JCXB3bS1waW5zIHsNCj4gPiArCXB3
bTBfcGluczogcHdtMC0wIHsNCj4gPiArCQlwd20wLXBpbnMgew0KPiA+ICAJCQlwaW5tdXggPSA8
R1BJT01VWCg3LA0KPiA+ICAJCQkJICBHUE9fUFdNX1BBRF9PVVRfQklUMCwNCj4gPiAgCQkJCSAg
R1BPX1BXTV9QQURfT0VfTl9CSVQwLA0KPiA+IC0JCQkJICBHUElfTk9ORSk+LA0KPiA+IC0JCQkJ
IDxHUElPTVVYKDUsDQo+ID4gKwkJCQkgIEdQSV9OT05FKT47DQo+ID4gKwkJCWJpYXMtZGlzYWJs
ZTsNCj4gPiArCQkJZHJpdmUtc3RyZW5ndGggPSA8MzU+Ow0KPiA+ICsJCQlpbnB1dC1kaXNhYmxl
Ow0KPiA+ICsJCQlpbnB1dC1zY2htaXR0LWRpc2FibGU7DQo+ID4gKwkJCXNsZXctcmF0ZSA9IDww
PjsNCj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlwd20xX3BpbnM6IHB3bTEtMCB7
DQo+ID4gKwkJcHdtMS1waW5zIHsNCj4gPiArCQkJcGlubXV4ID0gIDxHUElPTVVYKDUsDQo+ID4g
IAkJCQkgIEdQT19QV01fUEFEX09VVF9CSVQxLA0KPiA+ICAJCQkJICBHUE9fUFdNX1BBRF9PRV9O
X0JJVDEsDQo+ID4gIAkJCQkgIEdQSV9OT05FKT47DQo+ID4gQEAgLTM1OSw5ICszNjksMTUgQEAg
Jm9zY19hdWQgew0KPiA+ICAJY2xvY2stZnJlcXVlbmN5ID0gPDI3MDAwMDAwPjsNCj4gPiAgfTsN
Cj4gPg0KPiA+IC0mcHdtIHsNCj4gPiArJnB3bTAgew0KPiA+ICsJcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4gPiArCXBpbmN0cmwtMCA9IDwmcHdtMF9waW5zPjsNCj4gPiArCXN0YXR1cyA9
ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwd20xIHsNCj4gPiAgCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+ID4gLQlwaW5jdHJsLTAgPSA8JnB3bV9waW5zPjsNCj4gPiArCXBp
bmN0cmwtMCA9IDwmcHdtMV9waW5zPjsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEw
MC5kdHNpDQo+ID4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpDQo+
ID4gaW5kZXggN2RlMDczMmI4ZWFiLi40NjI5ZTk3NDczMDcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTAwLmR0c2kNCj4gPiBAQCAtMzYwLDkgKzM2MCw3MiBA
QCB3YXRjaGRvZ0AxMjQ4MDAwMCB7DQo+ID4gIAkJCQkgPCZyc3RnZW4gSkg3MTAwX1JTVE5fV0RU
PjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gLQkJcHdtOiBwd21AMTI0OTAwMDAgew0KPiA+IC0JCQlj
b21wYXRpYmxlID0gInN0YXJmaXZlLGpoNzEwMC1wd20iLCAib3BlbmNvcmVzLHB3bS12MSI7DQo+
ID4gLQkJCXJlZyA9IDwweDAgMHgxMjQ5MDAwMCAweDAgMHgxMDAwMD47DQo+ID4gKwkJcHdtMDog
cHdtQDEyNDkwMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJvcGVuY29yZXMscHdtLXYxIjsN
Cj4gPiArCQkJcmVnID0gPDB4MCAweDEyNDkwMDAwIDB4MCAweDEwPjsNCj4gDQo+IE5BSyBvbiB0
aGUgY29tcGF0aWJsZXMgZnJvbnQsIGJ1dCB0aGlzIGFsc28gbG9va3MgdmVyeSBzdXNwZWN0LCBn
aXZlbiB0aGUgc2l6ZSBvZg0KPiB0aGUgcmVnaXN0ZXIgcmVnaW9ucywgYnV0IEkgdGhpbmsgaXQg
aXMgYWN0dWFsbHkgY29ycmVjdC4NCj4gWW91IG5lZWQgdG8gZXhwbGFpbiB3aHkgaXQgaXMgY29y
cmVjdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCk9LLiBXaWxsIGtlZXAgdGhlIG9sZCBjb21w
YXRpYmxlcyBhbmQgZXhwbGFpbiB0aGUgY2hhbmdlIG9mIHJlZ2lzdGVyIHNpemUgaW4NCnRoZSBj
b21taXQgbWVzc2FnZS4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=

