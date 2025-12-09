Return-Path: <linux-pwm+bounces-7787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6462FCAF9F5
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Dec 2025 11:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DBB630041AA
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Dec 2025 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0025A321;
	Tue,  9 Dec 2025 10:20:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CA13774D;
	Tue,  9 Dec 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275656; cv=none; b=hdWRB45bWfibPg/cERUme9g1Mfv1MvltjQP3g1IYWH6rg+UvHjVWc+25ye3Rzealr3BPVcta9UVmMyTw0NhuaYcnrQO8KKlko0dwq1N0Y3MtyZBU9UdHNiTaYQofkbsyPRrrcMkhhLD66eUYZ/JAZFnjmejg6MzCwHE9TRYThfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275656; c=relaxed/simple;
	bh=0igFMeA4r8WgMm2AgCebME9sRmF3+EaQ8kuAiHD7q90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VaNrFN46p2F9CgFwjlKpDSQqda6yAW7AWaZ1Z0gJU/KaRMdqCorKl5VWwPVJ1JBXMwTwFUzqoe/lUS1veqCGC3xzbc/LP3qeeb+S9xJz1i3j2nDEfTatINJa2aU2k3+eXDUH8YA53ICCcS0exO33J+RqS/oTZUSgtQ0Ecl6JztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 9 Dec 2025 18:20:26 +0800 (GMT+08:00)
Date: Tue, 9 Dec 2025 18:20:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, ben.dooks@codethink.co.uk
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH 1/2] dt-bindings: pwm: eswin: Add EIC7700 pwm
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20251208-rational-trout-of-purring-a6150a@quoll>
References: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
 <20251205090450.1446-1-dongxuyang@eswincomputing.com>
 <20251208-rational-trout-of-purring-a6150a@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <47025bea.10ca.19b02a06c69.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDnK6_q9zdp+DCDAA--.3844W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQELAmk2-YUhH
	gABsQ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2Vz
d2luLGVpYzc3MDAtcHdtLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cHdtL2Vzd2luLGVpYzc3MDAtcHdtLnlhbWwKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjhiN2RjN2Q0ZGZmZQo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9lc3dpbixlaWM3NzAwLXB3
bS55YW1sCj4gPiBAQCAtMCwwICsxLDczIEBACj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpCj4gPiArJVlBTUwgMS4yCj4gPiArLS0t
Cj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wd20vZXN3aW4sZWljNzcw
MC1wd20ueWFtbCMKPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCMKPiA+ICsKPiA+ICt0aXRsZTogRVNXSU4gRUlDNzcwMCBQV00gY29udHJv
bGxlcgo+ID4gKwo+ID4gK21haW50YWluZXJzOgo+ID4gKyAgLSBYaWFuZyBYdSA8eHV4aWFuZ0Bl
c3dpbmNvbXB1dGluZy5jb20+Cj4gPiArICAtIEd1b3NoZW5nIFdhbmcgPHdhbmdndW9zaGVuZ0Bl
c3dpbmNvbXB1dGluZy5jb20+Cj4gPiArICAtIFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2lu
Y29tcHV0aW5nLmNvbT4KPiA+ICsKPiA+ICtkZXNjcmlwdGlvbjogfAo+IAo+IERvIG5vdCBuZWVk
ICd8JyB1bmxlc3MgeW91IG5lZWQgdG8gcHJlc2VydmUgZm9ybWF0dGluZy4KPiAKPiA+ICsgIFRo
ZSBFSUM3NzAwIFBXTSB1c2VkIHRoZSBEZXNpZ25XYXJlIEFQQiB0aW1lcnMgbW9kdWxlLiBUaGUg
UFdNIGRyaXZlcgo+ID4gKyAgc3VwcG9ydHMgYSBkdXR5IGN5Y2xlIHJhbmdlIGZyb20gMCUgdG8g
MTAwJSwgd2l0aCBleHBsaWNpdCBzdXBwb3J0IGZvcgo+IAo+IERyaXZlciBpcyBpcnJlbGV2YW50
IGhlcmUuIERlc2NyaWJlIGhhcmR3YXJlLgo+IAo+ID4gKyAgYm90aCAwJSBhbmQgMTAwJSBkdXR5
IGN5Y2xlcy4KPiA+ICsKPiA+ICthbGxPZjoKPiA+ICsgIC0gJHJlZjogcHdtLnlhbWwjCj4gPiAr
Cj4gPiArcHJvcGVydGllczoKPiA+ICsgIGNvbXBhdGlibGU6Cj4gPiArICAgIGNvbnN0OiBlc3dp
bixlaWM3NzAwLXB3bQo+ID4gKwo+ID4gKyAgcmVnOgo+ID4gKyAgICBtYXhJdGVtczogMQo+ID4g
Kwo+ID4gKyAgY2xvY2tzOgo+ID4gKyAgICBtYXhJdGVtczogMQo+ID4gKwo+ID4gKyAgcmVzZXRz
Ogo+ID4gKyAgICBtYXhJdGVtczogMQo+ID4gKwo+ID4gKyAgIiNwd20tY2VsbHMiOgo+ID4gKyAg
ICBjb25zdDogMwo+ID4gKwo+ID4gKyAgcGluY3RybC0wOiB0cnVlCj4gPiArICBwaW5jdHJsLTE6
IHRydWUKPiA+ICsKPiA+ICsgIHBpbmN0cmwtbmFtZXM6Cj4gPiArICAgIG1pbkl0ZW1zOiAxCj4g
PiArICAgIGl0ZW1zOgo+ID4gKyAgICAgIC0gY29uc3Q6IGRlZmF1bHQKPiA+ICsgICAgICAtIGNv
bnN0OiBzbGVlcAo+ID4gKwo+ID4gKyAgc25wcyxwd20tZnVsbC1yYW5nZS1lbmFibGU6Cj4gCj4g
MS4gV3JvbmcgdmVuZG9yIHByZWZpeCwgdGhhdHMgZXN3aW4sIG5vdCBzbnBzLgo+IDIuIFdoeSBp
cyB0aGlzIGEgaGFyZHdhcmUgcHJvcGVydHk/IEkgcmVhbGx5IGRvIG5vdCBzZWUgdGhhdC4gWW91
Cj4gZGVzY3JpYmVkIHRoZSBkZXNpcmVkIExpbnV4IGZlYXR1cmUgb3IgYmVoYXZpb3IsIG5vdCB0
aGUgYWN0dWFsCj4gaGFyZHdhcmUuIFRoZSBiaW5kaW5ncyBhcmUgYWJvdXQgdGhlIGxhdHRlciwg
c28gaW5zdGVhZCB5b3UgbmVlZCB0bwo+IHJlcGhyYXNlIHRoZSBwcm9wZXJ0eSBhbmQgaXRzIGRl
c2NyaXB0aW9uIHRvIG1hdGNoIGFjdHVhbCBoYXJkd2FyZQo+IGNhcGFiaWxpdGllcy9mZWF0dXJl
cy9jb25maWd1cmF0aW9uIGV0Yy4KPiAKSGkgS3J6eXN6dG9mIGFuZCBCZW4sCgpUaGVyZSBpcyBh
IHBhdGNoIFsxXSBzdWJtbWl0dGVkIGJ5IEJlbiBEb29rIGEgZmV3IHllYXJzIGFnby4gVGhlwqAK
aW50ZW50aW9uIG9mIHRoaXMgcGF0Y2ggaXMgdG8gbWFrZSBEV0MgcHdtIGNvbnRyb2xsZXIgY2Fu
IGJlIHVzZWQgYXPCoApwbGF0Zm9ybSBkcml2ZXIuIFRoaXMgaXMgd2hhdCB3ZSBhcmUgY3VycmVu
dGx5IHdvcmtpbmcgb24uCkl0IHNlZW1zIHRoYXQgaXQgd291bGQgYmUgbW9yZSByZWFzb25hYmxl
IHRvIGNvbnRpbnVlIGltcHJvdmluZyB0aGlzwqAKcGF0Y2ggYW5kIG1ha2UgdGhlIERXQyBQV00g
ZHJpdmVyIHVuaXZlcnNhbCwgcmF0aGVyIHRoYW4gY3JlYXRpbmcgYcKgCnNlcGFyYXRlIEVTV0lO
IFBXTSBkcml2ZXIuCgpUaGUgRFdDIHB3bSAyLjEzYSB2ZXJzaW9uIHN1cHBvcnRzICJQdWxzZSBX
aWR0aCBNb2R1bGF0aW9uIHdpdGggMCUgYW5kwqAKMTAwJSBEdXR5IEN5Y2xlIiBieSBwcm9ncmFt
bWluZyBUSU1FUl8wTjEwMFBXTV9FTiBiaXQgZmllbGQuIFdlIGFsc2/CoAp3YW50IHRvIHN1cHBv
cnQgdGhpcyBuZXcgaGFyZHdhcmUgZmVhdHVyZS4gU28sIGFkZGluZyBhIG5ldyBwcm9wZXJ0eSzC
oApsaWtlIHNucHMsdGltZXItMG4xMDBwd20tZW4sIGluIHB3bS9zbnBzLGR3LWFwYi10aW1lcnMt
cHdtMi55YW1sCndvdWxkIGJlIGJldHRlcj8KCktyenlzenRvZiBhbmQgQmVuLCBkbyB5b3UgdGhp
bmsgdGhlIGFib3ZlIGFwcHJvYWNoIGlzIHJlYXNvbmFibGUgYW5kIGFjY2VwdGFibGU/CgpbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDkwNzE2MTI0Mi42NzE5MC03LWJlbi5k
b29rc0Bjb2RldGhpbmsuY28udWsvCgpSZWdhcmRzLApYdXlhbmcgRG9uZwo=

