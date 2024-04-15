Return-Path: <linux-pwm+bounces-1935-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C38A4DB1
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Apr 2024 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8151A1C20D26
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Apr 2024 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9025D49F;
	Mon, 15 Apr 2024 11:27:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86F5FBA3
	for <linux-pwm@vger.kernel.org>; Mon, 15 Apr 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180469; cv=none; b=YJG01xCvt3+ADA0Bmz3Vu/qpG2GI9xYfbsNmpoJNjpTy6BRbimtyF2qcbnYuk7ol+EPd55JiMHpvvDBHOwmSDwA+YsaSS0YmjyeG56AWNokEzQniOHEzqlvO+RCMOQ3EFUY0z1ufK+sJ0jcW8ShAF0kwzhJmXfdyTvy8991+cwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180469; c=relaxed/simple;
	bh=jDf2Y1vp1jyVxpwRw+0NqPRWWVE522F13Uzq66S7vSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W28G18i0u5jmyiBfwhE1tFrh3Wlw4vmt2dYGRv47FI7w4sJ8G7Vv9m+OmgKbEc0krf0rAtynLb7KM8exYRLLwPFXCzSqgiLyDzcSTXPnfsmAVXMgCgt0G2jbIX4rtCQPUAZog17d8Ala1oscYuPMuAbSXYSxJUD4+iWkDdAcUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 15 Apr
 2024 13:27:36 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.037; Mon, 15 Apr 2024 13:27:36 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Thread-Topic: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Thread-Index: AQHaictjh2dhWToPm0mPNkeTSyNMR7Ffb7aAgAmq/4A=
Date: Mon, 15 Apr 2024 11:27:35 +0000
Message-ID: <b2a6c620-2272-4aa2-98f5-863e7faeb5ab@actia.se>
References: <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
 <20240408154233.890293-1-john.ernberg@actia.se>
 <z6g6zbzwaejozhb7hxjnta2tawifa5diblz6ktdt6hnngazkfr@xclx4ooiuw63>
In-Reply-To: <z6g6zbzwaejozhb7hxjnta2tawifa5diblz6ktdt6hnngazkfr@xclx4ooiuw63>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A29059A2F57647260
Content-Type: text/plain; charset="utf-8"
Content-ID: <812333EAA628664B957BD0C49D53B6B8@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgVXdlLA0KDQpPbiA0LzkvMjQgOTo0OSBBTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+
IEhhbGxvLA0KPiANCj4gT24gTW9uLCBBcHIgMDgsIDIwMjQgYXQgMDM6NDI6MzlQTSArMDAwMCwg
Sm9obiBFcm5iZXJnIHdyb3RlOg0KPj4gU2VlaW5nIHRoaXMgcGF0Y2ggc2V0IG1hZGUgbWUgZXhj
aXRlZC4NCj4gDQo+IFxvLw0KPiANCj4+IERpZCB5b3UgY29uc2lkZXIgb3IgdHJ5IGEgcHdtX2xp
bmUgbW9kZWwgc3RydWN0dXJlLCB0aGF0IGlzIGNvbm5lY3RlZCB0byBhIGZpbGUNCj4+IGRlc2Ny
aXB0b3IsIG1vcmUgbGlrZSByZXF1ZXN0X2xpbmUgZnJvbSBncGlvIGNoYXJkZXZzPw0KPiANCj4g
SSdkIGJlIG9wZW4gZm9yIGFuIGV4dGVuc2lvbiB0aGF0IHNpbXBsaWZpZXMgZGV0ZWN0aW9uIG9m
IHdoaWNoIChjaGlwLA0KPiBod3B3bSkgcGFpciBjb3JyZXNwb25kcyB0byB3aGljaCB1c2FnZS4g
SXQgY291bGQgYmUgZmVkIGZyb20gYSBkZXZpY2UNCj4gdHJlZSBsaWtlOg0KPiANCj4gCSZwd20w
IHsNCj4gCQljb21wYXRpYmxlID0gLi4uOw0KPiAJCXJlZyA9IDwuLi4+Ow0KPiAJCSNwd20tY2Vs
bHMgPSA8Mz47DQo+IAkJcHdtLW5hbWVzID0gIm1vdG9yLWNvbnRyb2wiLCAiYmFja2xpZ2h0Iiwg
IiIsICJzdGF0dXMtbGVkIjsNCj4gCX0NCj4gDQo+IGFuZCBwcm92aWRlIGEgZnVuY3Rpb24gaW4g
bGlicHdtIHRoYXQgYWxsb3dzIHRvIGRldGVybWluZSB0aGUgY2hpcGlkIG9mDQo+IHRoZSBjaGlw
IGNvcnJlc3BvbmRpbmcgdG8gJnB3bTAgKG9yIGFuIG9wZW4gZmQgdG8gdGhhdCBkZXZpY2UpIGFu
ZCAzDQo+IHdoZW4gInN0YXR1cy1sZWQiIGlzIHNlYXJjaGVkIGZvci4NCj4gDQo+IFRoaXMgY291
bGQgYmUgZG9uZSBjb21wbGV0ZWx5IGluIHVzZXJzcGFjZSBJIHRoaW5rIChieSBpbnNwZWN0aW5n
DQo+IHN5c2ZzKSwgc28gSSB3b25kZXIgaWYgdGhpcyBjb3VsZCBiZSBhIGNvbXBsZXRlIHVzZXJz
cGFjZQ0KPiBpbXBsZW1lbnRhdGlvbi4gSSBsaWtlIGtlZXBpbmcgdGhlIGtlcm5lbCBBUEkgc2lt
cGxlLCBpLmUuIGxldCBpdCBvbmx5DQo+IHdvcmsgKGFzIGl0IGlzIG5vdykgb25seSB1c2luZyBj
aGlwaWQgYW5kIGh3cHdtLiBIbW0sIG1heWJlIG1ha2UgcHdtDQo+IG5hbWVzIGEga2VybmVsIGNv
bmNlcHQgZXhwb3NlZCB0byBzeXNmcyB0byBub3QgaGF2ZSB0byBoYXJkY29kZSB0aGUgZHQNCj4g
ZGV0YWlscyBpbnRvIGxpYnB3bT8hDQoNClNvdW5kcyBsaWtlIGl0IGNvdWxkIGJlIHdvcmthYmxl
IHRoYXQgd2F5LiBUaGFua3MhDQoNCj4gDQo+PiBXZSBoYXZlIGJlZW4gdXNpbmcgZ3BpbyBjaGFy
ZGV2cyBmb3IgYSB3aGlsZSBhbmQgcmVhbGx5IGJlbmVmaXR0ZWQgZnJvbSB0aGF0DQo+PiBvdmVy
IHRoZSBzeXNmcyBpbnRlcmZhY2UuIEkgd3JvdGUgYSBzaW1wbGUgd3JhcHBlciBhcm91bmQgdGhl
IFBXTSBzeXNmcw0KPj4gaW50ZXJmYWNlIG1pbWljaW5nIHRoZSB3YXkgZ3BpbyBjaGFyZGV2cyB3
b3JrIGZvciBQV00gdXNpbmcgZGlyZmQsIHRvIG1ha2Ugb3VyDQo+PiBhcHBsaWNhdGlvbiBkZXNp
Z24gbW9yZSBzdHJlYW1saW5lZC4NCj4gDQo+IGxpYnB3bSBjYW4gYWxzbyBmYWxsIGJhY2sgdG8g
c3lzZnMgd2hlbiB0aGUgY2hhcmFjdGVyIGRldmljZXMgYXJlDQo+IG1pc3NpbmcuIElmIHlvdSB3
YW50IHRvIGNvbXBhcmUgdGhlIHR3byBpbXBsZW1lbnRhdGlvbiBhbmQgY3JlYXRlIGEgYmVzdA0K
PiBvZiB0d28gbWVyZ2UgZnJvbSBpdCwgdGhhdCB3b3VsZCBiZSBncmVhdC4NCj4gDQo+PiBXaXRo
IHRoaXMgcGF0Y2ggc2V0IEkgZG8gbm90IHNlZSBob3cgd2UgY2FuIG5hbWUgdGhlIFBXTXMgaW4g
dGhlIGRldmljZSB0cmVlDQo+PiBub3IgZHVyaW5nIHJlcXVlc3Qgd2hpY2ggaXMgYSBiaWcgYmVu
ZWZpdCB3aXRoIEdQSU8gd2hlbiB3ZSBuZWVkIHRvIHN1cHBvcnQNCj4+IG11bHRpcGxlIGhhcmR3
YXJlcy4gTm9yIGNhbiBJIHNlZSBob3cgd2Ugd291bGQgaW5zcGVjdCB3aGljaCBwaW5zIGFyZQ0K
Pj4gYWxsb2NhdGVkIG9yIHRoZWlyIG5hbWVzIHdoZW4gZGVidWdnaW5nLg0KPiANCj4gQmVzdCBy
ZWdhcmRzDQo+IFV3ZQ0KPiANCg0KQmVzdCByZWdhcmRzIC8vIEpvaG4gRXJuYmVyZw==

