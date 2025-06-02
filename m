Return-Path: <linux-pwm+bounces-6232-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12079ACBC7D
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 22:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D1174E75
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 20:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7822538F;
	Mon,  2 Jun 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hyUgOkOn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46A2C327E
	for <linux-pwm@vger.kernel.org>; Mon,  2 Jun 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897587; cv=none; b=BMaev60nhqv+XeJoferzyXghPvITsZat88NHmm7VGox49L7QM8Z0srt0aIpmcxB/MKq3BaDYqIKTMgpsnQMhIm5bsd8uvurc4d8+MvZQLBo9n+9WpOmvbBP5h661pO8S96/WJVo229uJoD54WKMZzIX6brVWuP/4e9tWR3dFCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897587; c=relaxed/simple;
	bh=spJPdv3SxMsR+kVYLWWmXtxQIJc58Pfgt5/9zrFEoTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnFDJUCHTXJb7LkrxrXYU7uZcpTAIYrX5IA+13mmPjMplsEtycJ0g7hpC0SSuWM8RN/psDOpzKTX8OQyM9+WHXA7uiqGwTdazNRXqY//x/aXU0+WkXNNg2+rB0dZOl5SJmbprCb2EkL9fs8FWqko7prOk4eLudVIm5PxM1S43H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=hyUgOkOn; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E2F442C0372;
	Tue,  3 Jun 2025 08:52:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1748897576;
	bh=spJPdv3SxMsR+kVYLWWmXtxQIJc58Pfgt5/9zrFEoTo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hyUgOkOn5X3zkLYIOc4lJM4rsgU+CiZVcowX0r/xKpRVFlnGThYOEcTQvZ36P/XU3
	 phT7OjkavcFumvUe9T2hZjuWv8gzgKgElF8IhzPLPb7gYc6BV6WUUklrq3Rvnz3p7m
	 hIZ8YLnG0qxQKv20l0fn90FSSDvguCXqAXJY7xDlS2OQXur6I5AMfpJ9TjMlT2MQa2
	 UeFnFzDhri6UtDJUKWOKZXf5woajtqWwesTBTsjYm83EELfb9zYA9bn2PxYRvnyTWb
	 mdSFVb0i5aIIDu0DKT5XjBrINLsyqUCynCVeutQmjxwQr03VmWKVqgYBH0oTz419aH
	 WWNBoBHPGotCw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B683e0f280001>; Tue, 03 Jun 2025 08:52:56 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 3 Jun 2025 08:52:56 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Tue, 3 Jun 2025 08:52:56 +1200
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
Thread-Index: AQHa3IT3bvX/iipZGkiPmVYc9wkwxrPnwi+AgABGbYCAAKO4gIAA/Z6AgAJhDICABXNvAA==
Date: Mon, 2 Jun 2025 20:52:56 +0000
Message-ID: <d538cd42-f8b3-43cb-897d-d60c3af57300@alliedtelesis.co.nz>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
 <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
 <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
 <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>
 <dirkbdd5oeofjhy5pk6jiaixbuhmuq7axewhrd7bdghc3dp5x6@ok2uhywwz5ls>
In-Reply-To: <dirkbdd5oeofjhy5pk6jiaixbuhmuq7axewhrd7bdghc3dp5x6@ok2uhywwz5ls>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1E01981D71D9249981DD4F9B1F88EF9@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KqPu2nWN c=1 sm=1 tr=0 ts=683e0f28 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Nz_DCE0GXln2RDVxwVYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAzMC8wNS8yMDI1IDIxOjM4LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gSGVsbG8g
Q2hyaXMsDQo+DQo+IE9uIFdlZCwgTWF5IDI4LCAyMDI1IGF0IDA5OjE4OjM3UE0gKzAwMDAsIENo
cmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAyOC8wNS8yMDI1IDE4OjEwLCBVd2UgS2xlaW5lLUvD
tm5pZyB3cm90ZToNCj4+PiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHlvdSBuZWVkIHRoZSBk
ZWZhdWx0IHZhbHVlIGZvciBkdXR5IHRvDQo+Pj4gc3RhdGljYWxseSBzZXR1cCAob3Igb25seSBp
bml0aWFsaXplPykgYSBmYW4sIHJpZ2h0Pw0KPj4gQ29ycmVjdC4NCj4+DQo+Pj4gSSdtIG5vdCBz
dXJlIEkgbGlrZQ0KPj4+IGV4dGVuZGluZyAjcHdtLWNlbGxzIGZvciBhIGRlZmF1bHQgZHV0eSB2
YWx1ZS4gVGhpbmtpbmcgYWJvdXQgdGhhdCBhDQo+Pj4gd2hpbGUgSSdkIHByZWZlciBhIGJpbmRp
bmcgdGhhdCBsb29rcyBtb3JlIGxpa2UgdGhlIGNsb2NrIGNvbmZpZ3VyYXRpb24NCj4+PiBzdHVm
ZiBiZWNhdXNlIGFjdHVhbGx5IGhhdmluZyB0aGUgcGVyaW9kIGFuZCBmbGFncyBhcyBwYXJ0IG9m
IHRoZQ0KPj4+IHJlZmVyZW5jZSB0byB0aGUgUFdNIHRvIGJlIHVzZWQgaXMgYWxzbyBhIGJpdCBz
dHJhbmdlLiBTbyBJIGltYWdpbmUNCj4+PiBzb21ldGhpbmcgbGlrZToNCj4+Pg0KPj4+IAlteXB3
bTogcHdtIHsNCj4+PiAJCWNvbXBhdGlibGUgPSAiLi4uLiINCj4+PiAJCSNwd20tY2VsbHMgPSA8
MT47DQo+Pj4gCX07DQo+Pj4NCj4+PiAJZmFuIHsNCj4+PiAJCWNvbXBhdGlibGUgPSAicHdtLWZh
biI7DQo+Pj4gCQlwd21zID0gPCZteXB3bSAxPjsNCj4+PiAJCWFzc2lnbmVkLXB3bXMgPSA8Jm15
cHdtPjsNCj4+PiAJCWFzc2lnbmVkLXB3bS1kZWZhdWx0LXBlcmlvZC1sZW5ndGhzLW5zID0gPDQw
MDAwPjsNCj4+PiAJCWFzc2lnbmVkLXB3bS1kZWZhdWx0LWZsYWdzID0gPFBXTV9QT0xBUklUWV9J
TlZFUlRFRD47DQo+Pj4gCX07DQo+Pj4NCj4+PiBUaGVuIHNwZWNpZnlpbmcgYSBwZXJpb2QgKG9y
IGxhdGVyIGEgZHV0eSBjeWNsZSBsZW5ndGgpIHdvdWxkIGJlDQo+Pj4gb3B0aW9uYWwgYW5kIGNv
dWxkIGJlIHByb3ZpZGVkIGlmZiB0aGUgZGV2aWNlIG5lZWRzIHRoYXQgZm9yIG9wZXJhdGlvbi4N
Cj4+IFRoZSBmcmVxdWVuY3kgYW5kIGZsYWdzIHdlcmUgYWxyZWFkeSBwYXJ0IG9mIHRoZSBzdGFu
ZGFyZCAjcHdtLWNlbGxzDQo+PiB3aGljaCBJIHRoaW5rIGlzIHdoeSBJIHdhcyBlbmNvdXJhZ2Vk
IHRvIHVzZSB0aGVtLg0KPiBZZWFoLCB0aGF0IHBhcnQgaXMgZmluZS4gVGhpcyBtaWdodCBub3Qg
YmUgdGhlIGxvbmctdGVybSBmdXR1cmUsIGJ1dA0KPiB0b2RheSB0aGF0J3MgdGhlIG5vcm0uDQo+
DQo+PiBJIHdhcyBhbHNvIHRyeWluZyB0byBnZXQgc29tZXRoaW5nIHRoYXQgd291bGQgd29yayBh
cyBhbiBBQ1BJIG92ZXJsYXkNCj4+IHdoaWNoIHR1cm5lZCBvdXQgdG8gYmUgcmVhbGx5IGhhcmQu
DQo+IEkgZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgQUNQSSB0byBiZSBoZWxwZnVsIHdpdGggdGhp
cyBxdWVzdC4NCj4NCj4+PiBNeSBtYWlsIHdhcyBqdXN0IG1lIGJlaW5nIGZydXN0cmF0ZWQgYWJv
dXQgYW5vdGhlciBzcGVjaWFsIGNhc2UgdGhhdCBJJ2QNCj4+PiBoYXZlIHRvIGhhbmRsZSBpZiBJ
IGdvIGludG8gdGhhdCBkaXJlY3Rpb24uIEkgc2hvdWxkIGhhdmUgYmVlbiBtb3JlDQo+Pj4gYXR0
ZW50aXZlIHRvIHRoYXQgZGV2ZWxvcG1lbnQgYmVmb3JlIGl0IGVudGVyZWQgdGhlIG1haW5saW5l
Lg0KPj4gSSdkIGJlIGhhcHB5IHRvIGRlcHJlY2F0ZSB0aGUgNCBjZWxsIHRoaW5nIGFuZCByZXBs
YWNlIGl0IHdpdGggMyBjZWxsICsNCj4+IHZlbmRvciBwcm9wZXJ0eSBmb3IgdGhlIGRlZmF1bHQg
cGVyaW9kIGlmIHRoYXQgaGVscHMuDQo+IEkgd29uZGVyIGhvdyBvdGhlciBzaW1pbGFyIGRldmlj
ZXMgZGV0ZXJtaW5lIHRoZSBkZWZhdWx0IGR1dHkgY3ljbGUuDQo+IElzbid0IHRoZSBub3JtIHRv
IG1ha2UgdGhlIGZhbiByb3RhdGUgYXQgbWF4IHNwZWVkIGFuZCB0aGVuIHdoZW4NCj4gdXNlcnNw
YWNlIHRha2VzIG92ZXIgaXQncyBzcGVlZGVkIGRvd24/DQoNClllcyB0aGF0IGlzIHRoZSBub3Jt
YWwgKGFuZCBzZW5zaWJsZSB0aGluZyBkbyB0bykuIEJ1dCBvY2Nhc2lvbmFsbHkgDQpoYXJkd2Fy
ZSBkZXNpZ25lcnMgbGlrZSB0byB1c2UgaW5jcmVkaWJseSBvdmVyIHNwZWMnZMKgIGZhbnMgdGhh
dCBhcmUgDQpqdXN0IHJpZGljdWxvdXNseSBub2lzeS4gT24gc29tZSBwcm9kdWN0cyBJJ3ZlIHdv
cmtlZCBvbiB3ZSBhZGRlZCBiYXNpYyANCmZhbiBjb250cm9sIHRvIHUtYm9vdCBzbyB3ZSBjb3Vs
ZCBzaWxlbmNlIHRoZSBmYW5zIGVhcmx5IGluIHRoZSBib290LiBJIA0KYWxzbyBnYXRoZXIgdGhh
dCBpbiB0aGUgUEMgd29ybGQgdGhlIGZhbiBjb250cm9sIGlzIG9mdGVuIGRvbmUgDQpleHRlcm5h
bGx5IHRvIHRoZSBPUy4gSW4gdGhlIHNwZWNpZmljIGNhc2Ugd2VyZSBJIG5lZWRlZCB0aGlzIA0K
ZnVuY3Rpb25hbGl0eSBpdCB3YXMgYW4gZW1iZWRkZWQgeDg2XzY0IHNvIEkgaGFkIG5laXRoZXIg
VS1Cb290IG5vciBhIEJNQy4NCg0K

