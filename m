Return-Path: <linux-pwm+bounces-6168-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50513AC72AE
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FE85006C1
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA21DEFE0;
	Wed, 28 May 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rUy4DsoE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3DC21D5B8
	for <linux-pwm@vger.kernel.org>; Wed, 28 May 2025 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748467129; cv=none; b=W91ytrNxFd/hHVvBdUccG46OriC9+UsM+lPPNNl8IhOQEdT5gvmsUcD/eCTX3GK53cQOy35zLJLscZUqTS/DM+W6r7FRpH7KAF2EoIVhY15eb+JZp9blGdSMkg0UUJADX5b4X6DiOr6vuH/CYlP+WS/rNx00CXyXn+OVSaH5x0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748467129; c=relaxed/simple;
	bh=87Z8jQXIblyl3Z9604ErRyHcGxDcrQBw2aE0xqUIGhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lx/R6MSycDmEUVDRaZeuG9jZSp+I5P80iUDUv/7TDkMf4G29kTQIQq/wYZUPc2Zy7g0w4oI6aSsSRzU5tDrF9MCsJN2f+0W2xceF10USQdWYPhOx/3gN4vG0bben6/xnXfohxWsfBgCfwiLFlAPjzcQTR9F1jUAf+xJMJ81Qz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rUy4DsoE; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C981B2C04F7;
	Thu, 29 May 2025 09:18:37 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1748467117;
	bh=87Z8jQXIblyl3Z9604ErRyHcGxDcrQBw2aE0xqUIGhw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=rUy4DsoE0k8DBFK9dco1+WePCSomm7HXxiaX0Gc+Wq+477xHV/redd/RoRKg4x2S5
	 GxMmoBDGuPOqb80kEZTPfyoXmpStyYr4AdbiWa2suSudULedzRg1qu7vf41in9VP25
	 CTmCbd/bi1jYQPmE9q2Y/oh+6e279UNdRW9FmTjzf5K5Dk0kogaX+WM0u0KEeVHefb
	 mlWFThnSrSxvCc9xrzX3H3iB8Uf+owIlBZXmRf04YbcRq9bYR0jUWx5395aAUS6tGU
	 iLGJQ6/ERuBHPYGGqPbF6olnoNRCkMReHCr+48+T75phyam1m6+WRZXKD1CmiSFJHk
	 3SokYYk10WsyA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68377dad0001>; Thu, 29 May 2025 09:18:37 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 29 May 2025 09:18:37 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 29 May 2025 09:18:37 +1200
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
Thread-Index: AQHa3IT3bvX/iipZGkiPmVYc9wkwxrPnwi+AgABGbYCAAKO4gIAA/Z6A
Date: Wed, 28 May 2025 21:18:37 +0000
Message-ID: <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
 <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
 <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
In-Reply-To: <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD1E180607F2854AB434C83AC9E114CC@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KqPu2nWN c=1 sm=1 tr=0 ts=68377dad a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=ju0T-9Nitl0fB73lcS8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pWnsn8mx59Rxsc26IHH0:22
X-SEG-SpamProfiler-Score: 0

SGkgVXdlLA0KDQpPbiAyOC8wNS8yMDI1IDE4OjEwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToN
Cj4gSGVsbG8gQ2hyaXMsDQo+DQo+IE9uIFR1ZSwgTWF5IDI3LCAyMDI1IGF0IDA4OjI0OjU2UE0g
KzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAyOC8wNS8yMDI1IDA0OjEyLCBVd2Ug
S2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+PiBIZWxsbywNCj4+Pg0KPj4+IE9uIFR1ZSwgSnVsIDIz
LCAyMDI0IGF0IDEwOjE3OjM1QU0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+IEFk
ZCBmYW4gY2hpbGQgbm9kZXMgdGhhdCBhbGxvdyBkZXNjcmliaW5nIHRoZSBjb25uZWN0aW9ucyBm
b3IgdGhlDQo+Pj4+IEFEVDc0NzUgdG8gdGhlIGZhbnMgaXQgY29udHJvbHMuIFRoaXMgYWxzbyBh
bGxvd3Mgc2V0dGluZyBzb21lDQo+Pj4+IGluaXRpYWwgdmFsdWVzIGZvciB0aGUgcHdtIGR1dHkg
Y3ljbGUgYW5kIGZyZXF1ZW5jeS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFj
a2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+PiBSZXZpZXdlZC1i
eTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+DQo+
Pj4+IE5vdGVzOg0KPj4+PiAgICAgICBDaGFuZ2VzIGluIHY3Og0KPj4+PiAgICAgICAtIE5vbmUN
Cj4+Pj4gICAgICAgQ2hhbmdlcyBpbiB2NjoNCj4+Pj4gICAgICAgLSBDb2xsZWN0IHItYnkgZnJv
bSBSb2INCj4+Pj4gICAgICAgQ2hhbmdlcyBpbiB2NToNCj4+Pj4gICAgICAgLSBVc2UgbmFub3Nl
Y29uZHMgZm9yIFBXTSBmcmVxdWVuY3kgYW5kIGR1dHkgY3ljbGUgYXMgcGVyIGV4aXN0aW5nDQo+
Pj4+ICAgICAgICAgY29udmVudGlvbnMgZm9yIFBXTXMNCj4+Pj4gICAgICAgLSBTZXQgZmxhZ3Mg
dG8gMCBpbiBleGFtcGxlIHRvIG1hdGNoIGFkaSxwd20tYWN0aXZlLXN0YXRlIHNldHRpbmcNCj4+
Pj4gICAgICAgQ2hhbmdlcyBpbiB2NDoNCj4+Pj4gICAgICAgLSAwIGlzIG5vdCBhIHZhbGlkIGZy
ZXF1ZW5jeSB2YWx1ZQ0KPj4+PiAgICAgICBDaGFuZ2VzIGluIHYzOg0KPj4+PiAgICAgICAtIFVz
ZSB0aGUgcHdtIHByb3ZpZGVyL2NvbnN1bWVyIGJpbmRpbmdzDQo+Pj4+ICAgICAgIENoYW5nZXMg
aW4gdjI6DQo+Pj4+ICAgICAgIC0gRG9jdW1lbnQgMCBhcyBhIHZhbGlkIHZhbHVlIChsZWF2ZXMg
aGFyZHdhcmUgYXMtaXMpDQo+Pj4+DQo+Pj4+ICAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3
bW9uL2FkdDc0NzUueWFtbCAgICB8IDM1ICsrKysrKysrKysrKysrKysrKy0NCj4+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3
NDc1LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3
NS55YW1sDQo+Pj4+IGluZGV4IDA1MWM5NzZhYjcxMS4uZGYyYjViODg5ZTRkIDEwMDY0NA0KPj4+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55
YW1sDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9h
ZHQ3NDc1LnlhbWwNCj4+Pj4gQEAgLTUxLDYgKzUxLDI0IEBAIHByb3BlcnRpZXM6DQo+Pj4+ICAg
ICAgICAgIGVudW06IFswLCAxXQ0KPj4+PiAgICAgICAgICBkZWZhdWx0OiAxDQo+Pj4+ICAgIA0K
Pj4+PiArICAiI3B3bS1jZWxscyI6DQo+Pj4+ICsgICAgY29uc3Q6IDQNCj4+PiBJIGFza2VkIHRv
IGFkZCBzdXBwb3J0IGZvciAjcHdtLWNlbGxzID0gPDQ+IHRvIHRoZSBwd20gY29yZSBpbiByZXBs
eSB0bw0KPj4+IHY0IChzZWUNCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wd20v
ZHJxdmFvbjVsYjJlaTNqcW9mdXRicjZkZW1pYnlmZGhibXIyNHN2YTI3Z3pwcWRub25AZnhhN3Jw
bDMzaWloLykuDQo+Pj4NCj4+PiBJJ20gdW5oYXBweSB0byBzZWUgdGhpcyBtZXJnZWQgYW55aG93
IGluIGNvbWJpbmF0aW9uIHdpdGggYWQtaG9jIHBhcnNpbmcNCj4+PiBvZiB0aGUgcHdtIHByb3Bl
cnRpZXMgaW4gdGhlIGRyaXZlciA6LVwNCj4+IEFzIEkgbWVudGlvbmVkIGF0IHRoZSB0aW1lIHRo
ZSBhZHQ3NDc1IGlzIG5vdCBjdXJyZW50bHkgcHdtX2NoaXAgc28gSQ0KPj4gbmVlZCB0aGUgYWQt
aG9jIHBhcnNpbmcgaW4gdGhhdCBkcml2ZXIuIEknZCBiZSBoYXBweSB0byB0YWtlIHlvdQ0KPj4g
cHJvdG90eXBlIHBhdGNoIGZvciBwd20vY29yZS5jIGFuZCBwb2xpc2ggaXQgYWx0aG91Z2ggSSBk
b24ndCByZWFsbHkNCj4+IGhhdmUgYSBnb29kIHdheSBvZiB0ZXN0aW5nIGl0Lg0KPiBJdCdzIG1v
cmUgdGhlIGRldmlhdGlvbiBvZiB0aGUgZGVmYXVsdCBiaW5kaW5nIGZvciBQV01zIHRoYXQgSSBk
b24ndA0KPiBsaWtlIHRoYW4gdGhlIGFkLWhvYyBwYXJzaW5nLiBJZGVhbGx5IHRoZSBhZHQ3NDc1
IHdvdWxkIHByb3ZpZGUgYQ0KPiBwd21jaGlwIChhcyB0aGUgYmluZGluZyBzdWdnZXN0cykgYW5k
IHRoZSBmYW4gd291bGQgYmUgZm9ybWFsaXplZCBhcyBhDQo+IHB3bS1mYW4uIFdpdGggdGhlIGJp
bmRpbmcgdGhhdCB3YXMgY2hvc2VuIGhlcmUgdGhhdCBvcHRpb24gYmVjb21lcyBtb3JlDQo+IHVn
bHkgdGhhbiBuZWNlc3NhcnkgdG8gaW1wbGVtZW50Lg0KPg0KPiBJZiBJIHVuZGVyc3RhbmQgY29y
cmVjdGx5IHlvdSBuZWVkIHRoZSBkZWZhdWx0IHZhbHVlIGZvciBkdXR5IHRvDQo+IHN0YXRpY2Fs
bHkgc2V0dXAgKG9yIG9ubHkgaW5pdGlhbGl6ZT8pIGEgZmFuLCByaWdodD8NCkNvcnJlY3QuDQo+
IEknbSBub3Qgc3VyZSBJIGxpa2UNCj4gZXh0ZW5kaW5nICNwd20tY2VsbHMgZm9yIGEgZGVmYXVs
dCBkdXR5IHZhbHVlLiBUaGlua2luZyBhYm91dCB0aGF0IGENCj4gd2hpbGUgSSdkIHByZWZlciBh
IGJpbmRpbmcgdGhhdCBsb29rcyBtb3JlIGxpa2UgdGhlIGNsb2NrIGNvbmZpZ3VyYXRpb24NCj4g
c3R1ZmYgYmVjYXVzZSBhY3R1YWxseSBoYXZpbmcgdGhlIHBlcmlvZCBhbmQgZmxhZ3MgYXMgcGFy
dCBvZiB0aGUNCj4gcmVmZXJlbmNlIHRvIHRoZSBQV00gdG8gYmUgdXNlZCBpcyBhbHNvIGEgYml0
IHN0cmFuZ2UuIFNvIEkgaW1hZ2luZQ0KPiBzb21ldGhpbmcgbGlrZToNCj4NCj4gCW15cHdtOiBw
d20gew0KPiAJCWNvbXBhdGlibGUgPSAiLi4uLiINCj4gCQkjcHdtLWNlbGxzID0gPDE+Ow0KPiAJ
fTsNCj4NCj4gCWZhbiB7DQo+IAkJY29tcGF0aWJsZSA9ICJwd20tZmFuIjsNCj4gCQlwd21zID0g
PCZteXB3bSAxPjsNCj4gCQlhc3NpZ25lZC1wd21zID0gPCZteXB3bT47DQo+IAkJYXNzaWduZWQt
cHdtLWRlZmF1bHQtcGVyaW9kLWxlbmd0aHMtbnMgPSA8NDAwMDA+Ow0KPiAJCWFzc2lnbmVkLXB3
bS1kZWZhdWx0LWZsYWdzID0gPFBXTV9QT0xBUklUWV9JTlZFUlRFRD47DQo+IAl9Ow0KPg0KPiBU
aGVuIHNwZWNpZnlpbmcgYSBwZXJpb2QgKG9yIGxhdGVyIGEgZHV0eSBjeWNsZSBsZW5ndGgpIHdv
dWxkIGJlDQo+IG9wdGlvbmFsIGFuZCBjb3VsZCBiZSBwcm92aWRlZCBpZmYgdGhlIGRldmljZSBu
ZWVkcyB0aGF0IGZvciBvcGVyYXRpb24uDQoNClRoZSBmcmVxdWVuY3kgYW5kIGZsYWdzIHdlcmUg
YWxyZWFkeSBwYXJ0IG9mIHRoZSBzdGFuZGFyZCAjcHdtLWNlbGxzIA0Kd2hpY2ggSSB0aGluayBp
cyB3aHkgSSB3YXMgZW5jb3VyYWdlZCB0byB1c2UgdGhlbS4gSSB3YXMgYWxzbyB0cnlpbmcgdG8g
DQpnZXQgc29tZXRoaW5nIHRoYXQgd291bGQgd29yayBhcyBhbiBBQ1BJIG92ZXJsYXkgd2hpY2gg
dHVybmVkIG91dCB0byBiZSANCnJlYWxseSBoYXJkLg0KDQo+IE15IG1haWwgd2FzIGp1c3QgbWUg
YmVpbmcgZnJ1c3RyYXRlZCBhYm91dCBhbm90aGVyIHNwZWNpYWwgY2FzZSB0aGF0IEknZA0KPiBo
YXZlIHRvIGhhbmRsZSBpZiBJIGdvIGludG8gdGhhdCBkaXJlY3Rpb24uIEkgc2hvdWxkIGhhdmUg
YmVlbiBtb3JlDQo+IGF0dGVudGl2ZSB0byB0aGF0IGRldmVsb3BtZW50IGJlZm9yZSBpdCBlbnRl
cmVkIHRoZSBtYWlubGluZS4NCkknZCBiZSBoYXBweSB0byBkZXByZWNhdGUgdGhlIDQgY2VsbCB0
aGluZyBhbmQgcmVwbGFjZSBpdCB3aXRoIDMgY2VsbCArIA0KdmVuZG9yIHByb3BlcnR5IGZvciB0
aGUgZGVmYXVsdCBwZXJpb2QgaWYgdGhhdCBoZWxwcy4NCj4NCj4gQmVzdCByZWdhcmRzDQo+IFV3
ZQ==

