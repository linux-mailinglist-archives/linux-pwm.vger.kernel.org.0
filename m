Return-Path: <linux-pwm+bounces-6154-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089BFAC5B4F
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990C61BA2640
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C41207A16;
	Tue, 27 May 2025 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RYbLQG0V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E81B4242
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748377507; cv=none; b=eBbSKpCDsCQIMuOvLVtIvrXu4joFGKfYutOIYLYJ3JFRJJKiWuhlZzFXfINw3N9giZQSojYYliNf0q/QatEloOO6FiX+4JKobShtCeSymeXCr1mz8ktaEXS1+HnAoYVvmR5wA1s/DfnbwiU0hvlTPDWBnwB8qd8/b6AIshO+ffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748377507; c=relaxed/simple;
	bh=2hYkwiQZhc9UgeL4PW98M4dhC9uekP+ZhSaZTfJBMrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/hmvzAysMABcfaP3h+nOF/eK7aHZtK8x0OwS1KUWGK4CXgQGmUEjT5nDDRuCLMTyDp9QWrBxTaik5YBFF/RoMxLoTBMykLFOKpBjRUU4zDE6ud7eH5qwkcCQrEdMnPXrW5RYORQL3he0Rzg8h71/JOXBSgznjZaMEWpunVax9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=RYbLQG0V; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C5A7E2C02EB;
	Wed, 28 May 2025 08:24:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1748377496;
	bh=2hYkwiQZhc9UgeL4PW98M4dhC9uekP+ZhSaZTfJBMrg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RYbLQG0V18YfJyZZqtQx8hTGo/7n7nj3KVu26jzVKiS9AUblS1yY67rsU3hPZ1mio
	 y55KMWjejMR18vW6Ko7mSoNTe8ownzSgPRcrr+RVEu5RCcqD4rWn5NN8zWChx/GUti
	 zHNvL0/YuCVMh7Sk2R2IIefjn3k3BL1euul98h2IZKgkBhnFmvkAbtIU/zDCiEh9f7
	 TG74ANB8enR7RWGhj+iCBvgp3dC5dljol6KMnEhySkBqUhl/vji2zww3WGbwKU1JXe
	 IWj9/uWFhiHgHopTLcYO/1e2vnkzjN0Bo/k4qrKIIWlJmBjiYvg8X8bUQv6IIqTed2
	 U2Hd/Y4Pc1l9w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68361f980001>; Wed, 28 May 2025 08:24:56 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 28 May 2025 08:24:56 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Wed, 28 May 2025 08:24:56 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Thread-Topic: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm
 properties
Thread-Index: AQHa3IT3bvX/iipZGkiPmVYc9wkwxrPnwi+AgABGbYA=
Date: Tue, 27 May 2025 20:24:56 +0000
Message-ID: <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
In-Reply-To: <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <626161CF4ACA8540904283514BE69EF9@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KqPu2nWN c=1 sm=1 tr=0 ts=68361f98 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=lkIoBbdPWXNUdUWQBiAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgVXdlLA0KDQpPbiAyOC8wNS8yMDI1IDA0OjEyLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToN
Cj4gSGVsbG8sDQo+DQo+IE9uIFR1ZSwgSnVsIDIzLCAyMDI0IGF0IDEwOjE3OjM1QU0gKzEyMDAs
IENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBBZGQgZmFuIGNoaWxkIG5vZGVzIHRoYXQgYWxsb3cg
ZGVzY3JpYmluZyB0aGUgY29ubmVjdGlvbnMgZm9yIHRoZQ0KPj4gQURUNzQ3NSB0byB0aGUgZmFu
cyBpdCBjb250cm9scy4gVGhpcyBhbHNvIGFsbG93cyBzZXR0aW5nIHNvbWUNCj4+IGluaXRpYWwg
dmFsdWVzIGZvciB0aGUgcHdtIGR1dHkgY3ljbGUgYW5kIGZyZXF1ZW5jeS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28u
bno+DQo+PiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4N
Cj4+IC0tLQ0KPj4NCj4+IE5vdGVzOg0KPj4gICAgICBDaGFuZ2VzIGluIHY3Og0KPj4gICAgICAt
IE5vbmUNCj4+ICAgICAgQ2hhbmdlcyBpbiB2NjoNCj4+ICAgICAgLSBDb2xsZWN0IHItYnkgZnJv
bSBSb2INCj4+ICAgICAgQ2hhbmdlcyBpbiB2NToNCj4+ICAgICAgLSBVc2UgbmFub3NlY29uZHMg
Zm9yIFBXTSBmcmVxdWVuY3kgYW5kIGR1dHkgY3ljbGUgYXMgcGVyIGV4aXN0aW5nDQo+PiAgICAg
ICAgY29udmVudGlvbnMgZm9yIFBXTXMNCj4+ICAgICAgLSBTZXQgZmxhZ3MgdG8gMCBpbiBleGFt
cGxlIHRvIG1hdGNoIGFkaSxwd20tYWN0aXZlLXN0YXRlIHNldHRpbmcNCj4+ICAgICAgQ2hhbmdl
cyBpbiB2NDoNCj4+ICAgICAgLSAwIGlzIG5vdCBhIHZhbGlkIGZyZXF1ZW5jeSB2YWx1ZQ0KPj4g
ICAgICBDaGFuZ2VzIGluIHYzOg0KPj4gICAgICAtIFVzZSB0aGUgcHdtIHByb3ZpZGVyL2NvbnN1
bWVyIGJpbmRpbmdzDQo+PiAgICAgIENoYW5nZXMgaW4gdjI6DQo+PiAgICAgIC0gRG9jdW1lbnQg
MCBhcyBhIHZhbGlkIHZhbHVlIChsZWF2ZXMgaGFyZHdhcmUgYXMtaXMpDQo+Pg0KPj4gICAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnlhbWwgICAgfCAzNSArKysrKysrKysr
KysrKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9od21vbi9hZHQ3NDc1LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+PiBpbmRleCAwNTFjOTc2YWI3MTEuLmRmMmI1Yjg4OWU0
ZCAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21v
bi9hZHQ3NDc1LnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9od21vbi9hZHQ3NDc1LnlhbWwNCj4+IEBAIC01MSw2ICs1MSwyNCBAQCBwcm9wZXJ0aWVzOg0K
Pj4gICAgICAgICBlbnVtOiBbMCwgMV0NCj4+ICAgICAgICAgZGVmYXVsdDogMQ0KPj4gICANCj4+
ICsgICIjcHdtLWNlbGxzIjoNCj4+ICsgICAgY29uc3Q6IDQNCj4gSSBhc2tlZCB0byBhZGQgc3Vw
cG9ydCBmb3IgI3B3bS1jZWxscyA9IDw0PiB0byB0aGUgcHdtIGNvcmUgaW4gcmVwbHkgdG8NCj4g
djQgKHNlZQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wd20vZHJxdmFvbjVsYjJl
aTNqcW9mdXRicjZkZW1pYnlmZGhibXIyNHN2YTI3Z3pwcWRub25AZnhhN3JwbDMzaWloLykuDQo+
DQo+IEknbSB1bmhhcHB5IHRvIHNlZSB0aGlzIG1lcmdlZCBhbnlob3cgaW4gY29tYmluYXRpb24g
d2l0aCBhZC1ob2MgcGFyc2luZw0KPiBvZiB0aGUgcHdtIHByb3BlcnRpZXMgaW4gdGhlIGRyaXZl
ciA6LVwNCg0KQXMgSSBtZW50aW9uZWQgYXQgdGhlIHRpbWUgdGhlIGFkdDc0NzUgaXMgbm90IGN1
cnJlbnRseSBwd21fY2hpcCBzbyBJIA0KbmVlZCB0aGUgYWQtaG9jIHBhcnNpbmcgaW4gdGhhdCBk
cml2ZXIuIEknZCBiZSBoYXBweSB0byB0YWtlIHlvdSANCnByb3RvdHlwZSBwYXRjaCBmb3IgcHdt
L2NvcmUuYyBhbmQgcG9saXNoIGl0IGFsdGhvdWdoIEkgZG9uJ3QgcmVhbGx5IA0KaGF2ZSBhIGdv
b2Qgd2F5IG9mIHRlc3RpbmcgaXQuDQoNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAg
ICBOdW1iZXIgb2YgY2VsbHMgaW4gYSBQV00gc3BlY2lmaWVyLg0KPj4gKyAgICAgIC0gMDogVGhl
IFBXTSBjaGFubmVsDQo+PiArICAgICAgLSAxOiBUaGUgUFdNIHBlcmlvZCBpbiBuYW5vc2Vjb25k
cw0KPj4gKyAgICAgICAgICAgLSA5MDkwOTA5MSAoMTEgSHopDQo+PiArICAgICAgICAgICAtIDcx
NDI4NTcxICgxNCBIeikNCj4+ICsgICAgICAgICAgIC0gNDU0NTQ1NDUgKDIyIEh6KQ0KPj4gKyAg
ICAgICAgICAgLSAzNDQ4Mjc1OSAoMjkgSHopDQo+PiArICAgICAgICAgICAtIDI4NTcxNDI5ICgz
NSBIeikNCj4+ICsgICAgICAgICAgIC0gMjI3MjcyNzMgKDQ0IEh6KQ0KPj4gKyAgICAgICAgICAg
LSAxNzI0MTM3OSAoNTggSHopDQo+PiArICAgICAgICAgICAtIDExMzYzNjM2ICg4OCBIeikNCj4+
ICsgICAgICAgICAgIC0gNDQ0NDQgKDIyIGtIeikNCj4+ICsgICAgICAtIDI6IFBXTSBmbGFncyAw
IG9yIFBXTV9QT0xBUklUWV9JTlZFUlRFRA0KPj4gKyAgICAgIC0gMzogVGhlIGRlZmF1bHQgUFdN
IGR1dHkgY3ljbGUgaW4gbmFub3NlY29uZHMNCj4+ICsNCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ==

