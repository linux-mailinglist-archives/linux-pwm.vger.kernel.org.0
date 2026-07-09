Return-Path: <linux-pwm+bounces-9649-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C03IFk/3TmqgXwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9649-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 03:20:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631E72BA29
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 03:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9649-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9649-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEFC6300FC97
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D721B4223;
	Thu,  9 Jul 2026 01:20:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E6DF6C;
	Thu,  9 Jul 2026 01:20:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560008; cv=none; b=udVdZ5/8LOLTS8h0vNVPeU/NyY2QIv0hgAetWmkiDT493OBi5Q2wPxnjCUb1KMWvZvdNc/aV1Qnz//9HGSY6G6R5du51ZDZsk/AykqrT2nOMfGNnzS4RrOFz+REOdOIKmfjOdt7HP7v1N4xgC79NrVOQ2sOBDX5R02vZ43v1ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560008; c=relaxed/simple;
	bh=SUpnqtG9DIgMc8e7n378Fhf5D1/4wACsdqE1qpJl36k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SeWSwrSDB8y23Owfq7D1CbVO3SbW1hic5o+XHFqGKc+9ZNWY4l2fxyPJGHubvyJIUa2TQjh5ZLF1A719jPJOXPFb4PeLbgxvXrZH8Xj4cYgAnTWYvoRxpHQozRHWKzg1z5majhMmEYKVZKYoKrV6s/0bluEPzeNWm1ae2Tt11cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.164.118
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 9 Jul 2026 09:19:47 +0800 (GMT+08:00)
Date: Thu, 9 Jul 2026 09:19:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: sashiko-reviews@lists.linux.dev
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v10 1/3] dt-bindings: pwm: dwc: Document optional
 resets property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260703094313.8EF191F000E9@smtp.kernel.org>
References: <20260703093308.482-1-dongxuyang@eswincomputing.com>
 <20260703093351.540-1-dongxuyang@eswincomputing.com>
 <20260703094313.8EF191F000E9@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a5ad21c.82a4.19f44759fe7.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqEz905qXp8yAA--.9174W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEDAmpOfBoHp
	wAAsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9649-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0631E72BA29

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIE1pc3Np
bmcgbWF0Y2hpbmcgdXBkYXRlcyBmb3IgcmVsYXRlZCBiaW5kaW5ncyBpbiB0aGUgc2FtZSBJUCBm
YW1pbHkuCj4gLS0KPiAKPiBjb21taXQgMDVkZDUwYzk4MmM1OThiODY5NDQ3NjVkOTFmMjk3YThj
MzdiMzAzZQo+IEF1dGhvcjogWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcu
Y29tPgo+IAo+IGR0LWJpbmRpbmdzOiBwd206IGR3YzogRG9jdW1lbnQgb3B0aW9uYWwgcmVzZXRz
IHByb3BlcnR5Cj4gCj4gVGhpcyBjb21taXQgdXBkYXRlcyB0aGUgRGVzaWduV2FyZSBQV00gYmlu
ZGluZyB0byBkb2N1bWVudCB0d28gYWN0aXZlLWxvdwo+IHJlc2V0IGlucHV0czogcHJlc2V0biBh
bmQgdGltZXJfTl9yZXNldG4uIEl0IGFkZHMgdGhlIHJlc2V0cyBwcm9wZXJ0eSB3aXRoCj4gdHdv
IGl0ZW1zIHRvIGRlc2NyaWJlIHRoZSBmdW5jdGlvbiBvZiBlYWNoIHJlc2V0IGxpbmUuCj4gCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBz
LGR3LWFwYi10aW1lcnMtcHdtMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3NucHMsZHctYXBiLXRpbWVycy1wd20yLnlhbWwK
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxkdy1h
cGItdGltZXJzLXB3bTIueWFtbAo+ID4gQEAgLTQzLDYgKzQzLDExIEBAIHByb3BlcnRpZXM6Cj4g
PiAgICAgICAgLSBjb25zdDogYnVzCj4gPiAgICAgICAgLSBjb25zdDogdGltZXIKPiA+ICAKPiA+
ICsgIHJlc2V0czoKPiA+ICsgICAgaXRlbXM6Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSW50
ZXJmYWNlIGJ1cyAocHJlc2V0bikgcmVzZXQKPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQV00g
dGltZXIgbG9naWMgKHRpbWVyX05fcmVzZXRuKSByZXNldAo+ID4gKwo+IAo+IFtTZXZlcml0eTog
TWVkaXVtXQo+IFRoZSBzdWJzeXN0ZW0gZ3VpZGVsaW5lcyBub3RlIHRoYXQgd2hlbiBhIGJpbmRp
bmcgaGFzIG11bHRpcGxlIFlBTUwgZmlsZXMgZm9yCj4gZGlmZmVyZW50IGRldmljZSB0eXBlcyBp
biB0aGUgc2FtZSBmYW1pbHksIHJlbGF0ZWQgZmlsZXMgbWF5IG5lZWQgbWF0Y2hpbmcKPiB1cGRh
dGVzLiBTaW5jZSB0aGUgRGVzaWduV2FyZSBBUEIgdGltZXIgSVAgaXMgZGVzY3JpYmVkIGJ5IGJv
dGggdGhpcyBQV00KPiBiaW5kaW5nIGFuZCB0aGUgdGltZXIgYmluZGluZywgZG9lcyB0aGUgdGlt
ZXIgYmluZGluZyBhbHNvIG5lZWQgYW4gdXBkYXRlPwo+IAo+IEN1cnJlbnRseSwgdGhlIHRpbWVy
IGJpbmRpbmcgcmVzdHJpY3RzIHRoZSByZXNldHMgcHJvcGVydHkgdG8gYSBzaW5nbGUgaXRlbToK
PiAKPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvc25wcyxkdy1hcGIt
dGltZXIueWFtbDpwcm9wZXJ0aWVzOnJlc2V0cwo+ICAgcmVzZXRzOgo+ICAgICBtYXhJdGVtczog
MQo+IAo+IERlZmluaW5nIGJvdGggaGFyZHdhcmUgcmVzZXRzIGZvciB0aGUgc25wcyxkdy1hcGIt
dGltZXIgY29tcGF0aWJsZSB3aWxsCj4gY2F1c2UgZHRfYmluZGluZ19jaGVjayB0byBmYWlsIGR1
ZSB0byB0aGlzIGluY29uc2lzdGVuY3kuCj4gCgpIaSBTYXNoaWtvLAoKVGhhbmtzIGZvciB0aGUg
Y2FyZWZ1bCByZXZpZXcuCgpUaGlzIGlzIG5vdCBhIGJpbmRpbmcgaW5jb25zaXN0ZW5jeSBpc3N1
ZToKwqAgLSBXZSdyZSBkZXNjcmliaW5nIGRpZmZlcmVudCBoYXJkd2FyZSB1c2FnZSBzY2VuYXJp
b3MgKFBXTSB2cyBjbG9ja3NvdXJjZSkKwqAgLSBUaGUgUFdNIGJpbmRpbmcgZGVzY3JpYmVzIHdo
YXQgdGhlIFBXTSBkcml2ZXIgYWN0dWFsbHkgbmVlZHMKwqAgLSBUaGUgdGltZXIgYmluZGluZyBk
ZXNjcmliZXMgd2hhdCB0aGUgdGltZXIgZHJpdmVyIGFjdHVhbGx5IG5lZWRzCsKgIC0gQm90aCBy
ZWZsZWN0IHRoZWlyIHJlc3BlY3RpdmUgaGFyZHdhcmUgcmVxdWlyZW1lbnRzIGFjY3VyYXRlbHkK
CkkgZG9uJ3QgdGhpbmsgdGhlIG51bWJlciBvZiBpdGVtcyBpbiB0aGUgcmVzZXRzIHByb3BlcnR5
IG9mIHRoZSB0aW1lciBiaW5kaW5nwqAKc2hvdWxkIGJlIHVwZGF0ZWQuIERvIHlvdSB0aGluayB0
aGlzIGlzIGFjY2VwdGFibGU/CgpCZXN0IHJlZ2FyZHMsClh1eWFuZyBEb25nCgo+ID4gICAgc25w
cyxwd20tbnVtYmVyOgo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzIKPiA+ICAgICAgZGVzY3JpcHRpb246IFRoZSBudW1iZXIgb2YgUFdNIGNoYW5u
ZWxzIGNvbmZpZ3VyZWQgZm9yIHRoaXMgaW5zdGFuY2UKPiAKPiAtLSAKPiBTYXNoaWtvIEFJIHJl
dmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA3MDMwOTMzMDguNDgy
LTEtZG9uZ3h1eWFuZ0Blc3dpbmNvbXB1dGluZy5jb20/cGFydD0xCg==

