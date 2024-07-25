Return-Path: <linux-pwm+bounces-2917-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F593CA0A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 23:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD891C21F14
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133C7D401;
	Thu, 25 Jul 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LbkS9bQJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69D502BE
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jul 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941360; cv=none; b=fDaIs8ErC/oyeyglgw/44aTxkyqfE+3jPx7sxm3DtQAOxSZARqBv9lzgxEFqTybRQOOODF2y82V3ikW3oYQRXmTToZmcI2KZlZTK10GDSzbR+YLu4mVuMsxfj72j82EJiqE+zoDjFxaXOVoAGiYIfEXbYUS8/kEFvxHzYNTx2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941360; c=relaxed/simple;
	bh=itACr6q6euo6bZmjeTw9qs8N0BkFk0gWez2lg4bJR3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PKCBgvFgfiwhp3MmleOC4URZ0Nd67NAKWamBGtx70MIvnBqLGTLpI+Bk2RieJQdhTbbkc6xgtvHce9l5dtQArFTBM7R22bfGADJQPositA5HGGrMLrDxtwE5wdzXkKA+XCgyU5RFciKidyUVv20G8hL3pdlGfM8fUYdZvMB7BMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=LbkS9bQJ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E70DF2C04A9;
	Fri, 26 Jul 2024 09:02:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721941348;
	bh=itACr6q6euo6bZmjeTw9qs8N0BkFk0gWez2lg4bJR3w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LbkS9bQJw8dedgsSBB3+i4G52hDocXnEd7yrnucY8Hv0FlgwMmk+dygkiE3xLm6zs
	 Kjvt5cdc9UBQUKVUbOBmILKY0GP8X6TSqWlo3R1Yf3rObJX8mAYWY3cN5uJis06Lby
	 sdtuQwLlEpol1wzcZfZiYmrlBoayBrI89t4SJl9EBZveUa3KvEk0pu5N2CFQpF9Jnz
	 FSAX0OTGvnSJDi4zpaUWjuLODaR7d7XsLo50kER7SKQKlhPJlOxoVi8Ldh8KO4y20j
	 ixC74ukimyJdXq0o6d4OrnzA/jrMPAShMCaVD92u7cpZHsAP8POi5HpTolDyvwIHSL
	 Gt5d7U7P7I9UQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66a2bd640001>; Fri, 26 Jul 2024 09:02:28 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jul 2024 09:02:28 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Fri, 26 Jul 2024 09:02:28 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "ukleinek@kernel.org"
	<ukleinek@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
Thread-Topic: [PATCH v7 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
Thread-Index: AQHa3IT3Zuzwz3xFwkKaciGnUdU3zLIGtlgAgABzS4A=
Date: Thu, 25 Jul 2024 21:02:28 +0000
Message-ID: <ee3b9800-4649-4e8a-af67-80713e76b79d@alliedtelesis.co.nz>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-4-chris.packham@alliedtelesis.co.nz>
 <aaa8217b-031d-40e7-96a7-b9ed8482748a@roeck-us.net>
In-Reply-To: <aaa8217b-031d-40e7-96a7-b9ed8482748a@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B30A173DDF236640BC96E73D55C672FA@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=66a2bd64 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=YMKABRJBKZM-AwbpdXYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNi8wNy8yNCAwMjowOSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gVHVlLCBKdWwg
MjMsIDIwMjQgYXQgMTA6MTc6MzdBTSArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEJ5
IGRlZmF1bHQgdGhlIFBXTSBkdXR5IGN5Y2xlIGluIGhhcmR3YXJlIGlzIDEwMCUuIE9uIHNvbWUg
c3lzdGVtcyB0aGlzDQo+PiBjYW4gY2F1c2UgdW53YW50ZWQgZmFuIG5vaXNlLiBBZGQgdGhlIGFi
aWxpdHkgdG8gc3BlY2lmeSB0aGUgZmFuDQo+PiBjb25uZWN0aW9ucyBhbmQgaW5pdGlhbCBzdGF0
ZSBvZiB0aGUgUFdNcyB2aWEgZGV2aWNlIHByb3BlcnRpZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBD
SEVDSzogQmxhbmsgbGluZXMgYXJlbid0IG5lY2Vzc2FyeSBiZWZvcmUgYSBjbG9zZSBicmFjZSAn
fScNCj4gIzIwNzogRklMRTogZHJpdmVycy9od21vbi9hZHQ3NDc1LmM6MTczNDoNCj4gKw0KPiAr
fQ0KPg0KPiBOZXZlciBtaW5kLCBhcHBsaWVkIGFmdGVyIGZpeGluZyB0aGUgYWJvdmUuDQoNCkht
bSwgb2RkIGNoZWNrcGF0Y2gucGwgZG9lc24ndCBjb21wbGFpbiBmb3IgbWUNCg0KJCAuL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCANCnBhdGNoZXMvYWR0LWluaXQtZHV0eS92Ny92Ny0wMDAzLWh3bW9u
LWFkdDc0NzUtQWRkLXN1cHBvcnQtZm9yLWNvbmZpZ3VyaW5nLWluaXRpYWwucGF0Y2ggDQoNCnRv
dGFsOiAwIGVycm9ycywgMCB3YXJuaW5ncywgMTQ5IGxpbmVzIGNoZWNrZWQNCg0KcGF0Y2hlcy9h
ZHQtaW5pdC1kdXR5L3Y3L3Y3LTAwMDMtaHdtb24tYWR0NzQ3NS1BZGQtc3VwcG9ydC1mb3ItY29u
ZmlndXJpbmctaW5pdGlhbC5wYXRjaCANCmhhcyBubyBvYnZpb3VzIHN0eWxlIHByb2JsZW1zIGFu
ZCBpcyByZWFkeSBmb3Igc3VibWlzc2lvbi4NCg0KPg0KPiBUaGFua3MsDQo+IEd1ZW50ZXI=

