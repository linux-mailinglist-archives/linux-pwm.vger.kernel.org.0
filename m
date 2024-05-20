Return-Path: <linux-pwm+bounces-2198-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DF8CA385
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 22:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B298D1C20A59
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845A139CE3;
	Mon, 20 May 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="x3QCy2/4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2D139CE8
	for <linux-pwm@vger.kernel.org>; Mon, 20 May 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238534; cv=none; b=fQdqcLCCrW6S6/Zjf0UuCuy7IDPQ1vv0vyJ1w6wJUkHhZ3r8A9VFuICiJq3xXY2FSFHVzaoM0HNNsCezQMfLWxh2Fp/oNIVQy5vxjQL0YUxdjcfWbpQNKdPCUkcgWc92IolKeO+6D7njeh3gznquoeiYwQ2TDIbn5QsAVMQmklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238534; c=relaxed/simple;
	bh=FY1p/wmrA6kcXFiHpWFc6CtUYphIKLuifGfTMZ7SkxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3EI1abAuq4sOzo47wcB6ahOT0h4o5fPg7F8YSvrdNoPZfVF8yr5XrHGc5rHC7OMoPb3gWzFZiFp8iJri1UxHQTJ3Rm6qQJbA/29hc76pszMR/38J7fcfsbXVVKkuvRxFXKAs2An7hCeolxv178jah3bm7bTAZBb4Z6Q8r5NvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=x3QCy2/4; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 65D442C0F83;
	Tue, 21 May 2024 08:55:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716238528;
	bh=FY1p/wmrA6kcXFiHpWFc6CtUYphIKLuifGfTMZ7SkxI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=x3QCy2/45BafBKzc35MME6kUiCmCNoPGtoAW/t7YZ+AW1C730cLnvove8ARTIueZO
	 8A3ngtYAa5KTLH6/I60Sl+jw0gFElbQzUMh41BWV/b7uvG2FaeFu8xt1eQ/jIE7PsS
	 p6sWZzG93TekjedeSN9VvmaaqxGP6sQZGNDYZDfJqfY0mjSEg7e8R63cZ6COzhV/6f
	 H8qdC5HGlNHKe98oTmcoMcis6KHjaCUCEe3WM7RFwQ77qKUi+iAdA2BjfccP+54s6v
	 8QVkffbJJKvirZgOQ89HBWE14AvXHRf/vyLBGgFMnzxi56NRb5rJWV3qWgRItLqZ+W
	 dRzXez6EA8QyA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B664bb8c00001>; Tue, 21 May 2024 08:55:28 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 May 2024 08:55:28 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 21 May 2024 08:55:28 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Conor Dooley <conor@kernel.org>, Guenter Roeck <linux@roeck-us.net>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "ukleinek@kernel.org"
	<ukleinek@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Thread-Topic: [PATCH v3 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm
 properties
Thread-Index: AQHaqmJINjerzqQHjU+Bh4jVLB5aBbGfjXmAgAAldACAAAqRgIAAFKiA
Date: Mon, 20 May 2024 20:55:27 +0000
Message-ID: <4de798f3-069e-4028-a5b5-5e6a639277e3@alliedtelesis.co.nz>
References: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
 <20240520030321.3756604-2-chris.packham@alliedtelesis.co.nz>
 <20240520-pendant-charity-a66a8d738690@spud>
 <62c3c546-5172-4417-a15a-d13419d42be3@roeck-us.net>
 <20240520-badly-islamist-dcae9fe1303b@spud>
In-Reply-To: <20240520-badly-islamist-dcae9fe1303b@spud>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCDFF3CED3C3E240AAD9211B102C9705@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=664bb8c0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=Db2xuwfgTYU1MdicWjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyMS8wNS8yNCAwNzo0MSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBNb24sIE1heSAy
MCwgMjAyNCBhdCAxMjowMzo0MlBNIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPj4gT24g
NS8yMC8yNCAwOTo0OSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+IE9uIE1vbiwgTWF5IDIwLCAy
MDI0IGF0IDAzOjAzOjE5UE0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+IEFkZCBm
YW4gY2hpbGQgbm9kZXMgdGhhdCBhbGxvdyBkZXNjcmliaW5nIHRoZSBjb25uZWN0aW9ucyBmb3Ig
dGhlDQo+Pj4+IEFEVDc0NzUgdG8gdGhlIGZhbnMgaXQgY29udHJvbHMuIFRoaXMgYWxzbyBhbGxv
d3Mgc2V0dGluZyBzb21lDQo+Pj4+IGluaXRpYWwgdmFsdWVzIGZvciB0aGUgcHdtIGR1dHkgY3lj
bGUgYW5kIGZyZXF1ZW5jeS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hh
bSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+PiAtLS0NCj4+Pj4NCj4+
Pj4gTm90ZXM6DQo+Pj4+ICAgICAgIENoYW5nZXMgaW4gdjM6DQo+Pj4+ICAgICAgIC0gVXNlIHRo
ZSBwd20gcHJvdmlkZXIvY29uc3VtZXIgYmluZGluZ3MNCj4+Pj4gICAgICAgQ2hhbmdlcyBpbiB2
MjoNCj4+Pj4gICAgICAgLSBEb2N1bWVudCAwIGFzIGEgdmFsaWQgdmFsdWUgKGxlYXZlcyBoYXJk
d2FyZSBhcy1pcykNCj4+Pj4NCj4+Pj4gICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24v
YWR0NzQ3NS55YW1sICAgIHwgMjUgKysrKysrKysrKysrKysrKysrLQ0KPj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0NzUu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1Lnlh
bWwNCj4+Pj4gaW5kZXggMDUxYzk3NmFiNzExLi45OWJkNjg5YWUwY2QgMTAwNjQ0DQo+Pj4+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnlhbWwN
Cj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0
NzUueWFtbA0KPj4+PiBAQCAtNTEsNiArNTEsMTUgQEAgcHJvcGVydGllczoNCj4+Pj4gICAgICAg
ICAgZW51bTogWzAsIDFdDQo+Pj4+ICAgICAgICAgIGRlZmF1bHQ6IDENCj4+Pj4gKyAgIiNwd20t
Y2VsbHMiOg0KPj4+PiArICAgIGNvbnN0OiA0DQo+Pj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+
Pj4gKyAgICAgIE51bWJlciBvZiBjZWxscyBpbiBhIFBXTSBzcGVjaWZpZXIuDQo+Pj4+ICsgICAg
ICAtIDA6IFRoZSBwd20gY2hhbm5lbA0KPj4+PiArICAgICAgLSAxOiBUaGUgcHdtIGZyZXF1ZW5j
eSBpbiBoZXJ0eiAtIDAsIDExLCAxNCwgMjIsIDI5LCAzNSwgNDQsIDU4LCA4OCwgMjI1MDANCj4+
PiBUaGUgc3RhbmRhcmQgYmluZGluZyBpcyBwZXJpb2QgaW4gbmFub3NlY29uZHMsIG5vdCBmcmVx
dWVuY3kgaW4gSHouDQo+Pj4gV2hhdCdzIGdhaW5lZCBmcm9tIGRldmlhdGluZyBmcm9tIHRoYXQ/
DQo+Pj4NCj4+IEknZCBzdHJvbmdseSBzdXNwZWN0IHRoYXQgQ2hyaXMgZGlkbid0IGtub3cgYW5k
IGRpZG4ndCBleHBlY3QgaXQsDQo+PiBqdXN0IGxpa2UgbWUuDQo+IEkgZGlkIHBvaW50IG91dCBv
biB2MiB0aGF0IHRoZSBpbmZvcm1hdGlvbiBvbiB0aGUgc3RhbmRhcmQgYmluZGluZyB3YXMNCj4g
aW4gcHdtLnR4dCwgYnV0IEkgYWxzbyBzYWlkICJvcmRlciBpdCBoYXMgPGluZGV4IGZyZXEgZmxh
Z3MgZHV0eT4iIHdoaWNoDQo+IGxpa2VseSBkaWRuJ3QgaGVscC4gSSBkaWQgaG93ZXZlciBDQyB5
b3UgYm90aCBvbiBhIHBhdGNoIHRoZSBvdGhlciBkYXkNCj4gd2hlcmUgSSBmaXhlZCBwd20ueWFt
bCBzbyB0aGF0IGl0IGFjdHVhbGx5IGNvbnRhaW5lZCB0aGUgaW5mb3JtYXRpb24gb24NCj4gd2hh
dCB0aGUgY2VsbHMgcmVwcmVzZW50ZWQuDQoNCkkgZGlkIHNlZSB0aGF0IHBhdGNoIHRoYW5rcy4g
QW5kIEkgZGlkIGFkanVzdCB0aGUgb3JkZXIgb2YgdGhlIA0KcGFyYW1ldGVycyBJIGhhZCBiYXNl
ZCBvbiBpdC4NCg0KSSBwZXJzb25hbGx5IGZvdW5kIGV4cHJlc3NpbmcgdGhlIGZyZXF1ZW5jeSBp
biBzZWNvbmRzIGNvbmZ1c2luZyB3aGljaCANCnRoZSBpcyBtYWluIHJlYXNvbiB3aHkgSSBzdHVj
ayB3aXRoIGhlcnR6LiBJIGFsc28gY291bGRuJ3QgZ3JvayBob3cgdG8gDQpleHByZXNzIHRoZSBk
dXR5IGN5Y2xlIGlmIEkgZGlkIGV4cHJlc3MgdGhlIGZyZXF1ZW5jeSBpbiBuYW5vc2Vjb25kcy4g
SSANCnRoaW5rIG1heWJlIEknbSBhIGJpdCBjb25mdXNlZCBhcyB0byBob3cgdG8gZXhwcmVzcyBh
IGdlbmVyaWMgUFdNIHBlcmlvZCANCndoZW4gdGhlIGNvbnRyb2xsZXIgSSdtIGRlYWxpbmcgd2l0
aCBoYXMgYSBmcmVxdWVuY3kgYW5kIGEgZHV0eSBjeWNsZS4NCg0KPj4+PiArICAgICAgLSAyOiBQ
V00gZmxhZ3MgMCBvciBQV01fUE9MQVJJVFlfSU5WRVJURUQNCj4+Pj4gKyAgICAgIC0gMzogVGhl
IGRlZmF1bHQgcHdtIGR1dHkgY3ljbGUgLSAwLTI1NQ0KPj4+IFNhbWUgaGVyZSBJIGd1ZXNzLCB3
aHkgbm90IG1hdGNoIHRoZSB1bml0cyB1c2VkIGZvciB0aGUgcGVyaW9kIGZvciB0aGUNCj4+PiBk
dXR5IGN5Y2xlPw0KPj4+DQo+PiBTYW1lIGhlcmUuIEkgYW0gdXNlZCB0byBwd20gZnJlcXVlbmN5
IGluIEh6IGFuZCBkdXR5IGN5Y2xlIGFzIHBlcmNlbnRhZ2UuDQo+PiBVc2luZyB0aGUgcGVyaW9k
IGluc3RlYWQgaXMgc29tZXdoYXQgdW51c3VhbCwgYW5kIEkgbXVzdCBhZG1pdCB0aGF0IEkNCj4+
IGhhdmUgbmV2ZXIgZW5jb3VudGVyZWQgaXQgd2hpbGUgZGVhbGluZyB3aXRoIGEgdmFyaWV0eSBv
ZiBmYW4gY29udHJvbGxlcnMuDQpNeSBleHBlY3RhdGlvbiBpcyB0aGF0IGEgZHV0eSBjeWNsZSBp
cyBhIHBlcmNlbnRhZ2UuIFRoZSBvbmx5IHJlYXNvbiBJJ20gDQp1c2luZyAwLTI1NSBpbnN0ZWFk
IG9mIDAtMTAwIGlzIGJlY2F1c2UgdGhhdCBtYXRjaGVzIHRoZSBzeXNmcyBBQkkuIEJ1dCANCkkn
ZCBoYXBwaWx5IGNoYW5nZSB0byBhIHRydWUgcGVyY2VudGFnZSAoaWYgSSBjYW4gZmlndXJlIG91
dCB0aGUgaW50ZWdlciANCm1hdGgpLCB3ZSdkIGxvc2UgYSBsaXR0bGUgYml0IG9mIHByZWNpc2lv
biBidXQgbm90aGluZyBhbnlvbmUgd291bGQgDQpyZWFsbHkgbm90aWNlLg0KPiBJZiBpdCBpcyB3
aGF0IG1ha2VzIHNlbnNlIHRvIHVzZSwgYmVjYXVzZSBpdCdzIHdoYXQgZXZlcnlvbmUgYW5kIHRo
ZWlyDQo+IG1vdGhlciBkb2N1bWVudHMsIHRoZW4gc3VyZS4gTXkgcmF0aW9uYWxlIEkgc3VwcG9z
ZSB3YXMgdGhyZWVmb2xkOg0KPiAtIENvbnNpc3RlbmN5IHdpdGggdGhlIHBlcmlvZA0KPiAtIFRp
bWUgd291bGQgYmUgbW9yZSBwb3J0YWJsZSBiZXR3ZWVuIHByb3ZpZGVycywgaWYgOCBiaXRzIG9m
IHByZWNpc2lvbg0KPiAgICBpcyBkZWVtZWQgaW5zdWZmaWNpZW50IGZvciBzb21lIHByb3ZpZGVy
cy4NCj4gLSBMYXN0ICYgbGVhc3QsIHRoZSBQV00gQVBJcyBpbiB0aGUga2VybmVsIHVzZSB0aW1l
IGZvciB0aGUgZHV0eWN5Y2xlDQo+DQo+IElmIHlvdSdyZSBnb2luZyB0byB1c2UgcGVyY2VudGFn
ZXMgcmF0aGVyIHRoYW4gdGltZSwgd291bGQgaXQgbm90DQo+IG1ha2UgbW9yZSBzZW5zZSB0byBl
aXRoZXIgdXNlIHBlcmNlbnQgaXRzZWxmIHdpdGggYSAwLTEwMCByYW5nZSBvciB1c2UNCj4gYmFz
aXMgcG9pbnRzIGlmIHBlcmNlbnQgZG9lc24ndCBwcm92aWRlIHN1ZmZpY2llbnQgZ3JhbnVsYXJp
dHk/DQo+DQo+IEkgdGhpbmsgaXQnZCBiZSBnb29kIG9mIFV3ZSBjaGltZWQgaW4sIGdpdmVuIHdl
J3JlIGRpc2N1c3NpbmcgYSBQV00NCj4gcHJvdmlkZXIgYmluZGluZyBhZnRlciBhbGwuDQoNCkkn
ZCBhbHNvIHBvaW50IG91dCBJJ20gbW9yZSB0aGFuIGhhcHB5IHRvIGdvIGJhY2sgdG8gbXkgdjIg
YXBwcm9hY2ggb2YgDQphZGRpbmcgc3BlY2lmaWMgcHJvcGVydGllcyBmb3IgdGhlIGZyZXF1ZW5j
eSBhbmQgZHV0eSBjeWNsZS4NCg0KPj4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHRo
aXMgY29ycmVjdGx5IC0gZHV0eSBjeWNsZXMgd291bGQNCj4gcy9kdXR5IGN5Y2xlcy9wZXJpb2Rz
Lw0KPg0KPj4gYmUgKHJvdW5kZWQpOg0KPj4NCj4+IEh6CW5zDQo+PiAxMQk5MCw5MDksMDkxDQo+
PiAxNAk3MSw0MjgsNTcxDQo+PiAyMgk0NSw0NTQsNTQ1DQo+PiAyOToJMzQsNDgyLDc1OQ0KPj4g
MzU6CTI4LDU3MSw0MjkNCj4+IDQ0OgkyMiw3MjcsMjczDQo+PiA1ODoJMTcsMjQxLDM3OQ0KPj4g
ODg6CTExLDM2Myw2MzYNCj4+IDIyNTAwCTQ0LDQ0NA0KPj4NCj4+IEV4YW1wbGVzIGZvciBkdXR5
IGN5Y2xlcyB3b3VsZCBiZQ0KPj4NCj4+IDIwJTogMCwycyBvciAyMDAsMDAwLDAwMA0KPj4gNTAl
OiAwLjVzIG9yIDUwMCwwMDAsMDAwDQo+PiA4MCU6IDAuOHMgb3IgODAwLDAwMCwwMDANCj4+DQo+
PiBJcyB0aGF0IGNvcnJlY3QgPw0KPiBBc3N1bWluZyBhIDEgc2Vjb25kIHBlcmlvZCwgdGhvc2Ug
bG9vayBhcyBleHBlY3RlZC4NCg0KVG8gbWUgdGhhdCBqdXN0IG1ha2VzIHRoaW5ncyBoYXJkZXIg
dG8gdW5kZXJzdGFuZC4gSWYgeW91IHdlcmUgcmVhZGluZyANCnRoZSBBRFQ3NDc1IGRhdGFzaGVl
dCB5b3UnZCBzZWUgdGhpbmdzIGxpa2UgdGhlIHN1cHBvcnRlZCBmcmVxdWVuY2llcyBvZiANCjEx
LCAxNCwgLi4uICwgODgsIDIyNTAwLiBIYXZpbmcgdG8gZXhwcmVzcyB0aGF0IGluIG5hbm9zZWNv
bmRzIHJlcXVpcmVzIA0KbWFraW5nIGEgYml0IG9mIGEgbGVhcC4gVGhlIGR1dHkgY3ljbGUgcGVy
Y2VudGFnZSB0byBuYW5vc2Vjb25kcyBpcyBtb3JlIA0Kc3RyYWlnaHQgZm9yd2FyZCBidXQgc2Vl
bXMgdW5uZWNlc3NhcmlseSBvYnNjdXJlIHRvIG1lLg0KDQo+DQo+IENoZWVycywNCj4gQ29ub3Iu
DQo+

