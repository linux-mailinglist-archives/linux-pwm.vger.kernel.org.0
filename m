Return-Path: <linux-pwm+bounces-8214-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA8WMPKSrml0GQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8214-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Mar 2026 10:29:22 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC072362AB
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Mar 2026 10:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591E3304566F
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2026 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05183793AD;
	Mon,  9 Mar 2026 09:24:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385E36A016;
	Mon,  9 Mar 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048254; cv=none; b=B6BYR+IWMrcRYaa7Z0oMrdh43zYuRyJhL8NEhWFFPXlVRyzwYSCG3VZGAufFTU9bB8DnYxkkSM38k4MTPkO8VCum4mjzoln5wDr8qbWABkQ/Wla9VacCJIa7xKLsBZiRkeamIhL0u9De0ES4upFMxWzB8P5xHe2AVoKBrdvqYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048254; c=relaxed/simple;
	bh=02tR7r7gblfPVrG5bcKvzRNn/L5Wjvf5FPlpKuT/rf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Gkme6Z86KWaYl2JCujOWLPGCALg6f3YUNZpnojD6l8NNZkYx0LgjCIb6+Dx0OEuITJOIZ327S9mC7X8+2ORqOnl6MKLAGyXMdIQ5oqmIZOlU+Vh2fM1JMj+FEUWjXAKC5z5ofUx9iYFTa/YvS6dlq+lC6TpO58fC4YS7YMh6Y7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 9 Mar 2026 17:24:02 +0800 (GMT+08:00)
Date: Mon, 9 Mar 2026 17:24:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v2 0/2] Update designware pwm driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <a88fa91a-20e8-4391-824b-8e16c910430d@kernel.org>
References: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
 <20260307-intrepid-curly-seagull-e036c4@quoll>
 <a88fa91a-20e8-4391-824b-8e16c910430d@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7e73ec54.3fe1.19cd1e922bc.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAHHaCyka5pxdkGAA--.1179W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmmtpQchr
	QACso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 2EC072362AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8214-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,eswincomputing.com:mid]
X-Rspamd-Action: no action

SGkgS3J6eXN6dG9mLAoKPiA+Pgo+ID4+IFRoZXJlIGlzIGFscmVhZHkgYSBwYXRjaCBbMV0gZm9y
IHRoZSBEZXNpZ25XYXJlIFBXTSBkcml2ZXIsIAo+ID4gCj4gPiBTbyBwcm92aWRlIHJldmlldyB0
aGVyZSBpbnN0ZWFkIG9mIGFsbG93aW5nIEJlbiB0byBwb3N0IGluY29tcGxldGUKPiA+IGhhcmR3
YXJlIGRlc2NyaXB0aW9uIHdoaWNoIHlvdSB3YW50IHRvIGNvcnJlY3QgaGVyZS4uLgo+ID4gCj4g
PiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHBvc3RpbmcgdGhpcyBjaGFuZ2UuCj4gCj4gSSBzZWUg
bm93IEJlbiBkaWQgbm90IHBvc3QgdGhlIGJpbmRpbmdzIGNoYW5nZSwgc28gdGhpcyBtZXNzYWdl
IGhlcmUKPiBqdXN0IGNvbmZ1c2VkIG1lLgoKV2Ugbm90aWNlZCBCZW7igJlzIERlc2lnbldhcmUg
UFdNIGRyaXZlciBzZXJpZXMgb24gbG9yZSBbMV0uIFRoZSBwYXRjaGVzIGZvcsKgCnRoZSBEVCBi
aW5kaW5ncywgcHdtLWR3Yy5jIGFuZCBwd20tZHdjLWNvcmUuYyBoYXZlIGFscmVhZHkgYmVlbiBt
ZXJnZWQgaW50b8KgCnRoZSBrZXJuZWwsIGZvciBleGFtcGxlLCBwYXRjaGVzIDEvNiwgMi82LCBh
bmQgMy82LsKgCkhvd2V2ZXIsIHRoZSBwd20tZHdjLW9mLmMgcGF0Y2ggaGFzIG5vdCB5ZXQgYmVl
biBhY2NlcHRlZCwgZm9yIGV4YW1wbGUswqAKcGF0Y2hlcyA0LzYsIDUvNiwgYW5kIDYvNi4KV2Ug
ZGlzY3Vzc2VkIHRoZSBzdGF0dXMgb2YgdGhpcyBQV00gc2VyaWVzIHdpdGggQmVuIG9uIGxvcmUu
IEdpdmVuIHRoZSBsYWNrwqAKb2YgcmVjZW50IHVwZGF0ZXMgZm9sbG93aW5nIEJlbuKAmXMgbWVz
c2FnZSBpbiBbMl0sIHdl4oCZZCBsaWtlIHRvIHN0ZXAgaW4gYW5kwqAKaGVscCBtb3ZlIHRoaXMg
Zm9yd2FyZC4KClRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIHY5IGFuZCBpbmNsdWRlcyB0aGUgZm9s
bG93aW5nIHVwZGF0ZXM6CjEuIE1pZ3JhdGVkIHRvIHRoZSBsYXRlc3QgUFdNIHN1YnN5c3RlbSBz
dHJ1Y3R1cmUgYW5kIEFQSXMuCjIuIEFkZGVkIHN1cHBvcnQgZm9yIDAlIGFuZCAxMDAlIGR1dHkg
Y3ljbGUgbW9kZXMuCjMuIEltcGxlbWVudGVkIGJhc2ljIHBvd2VyIG1hbmFnZW1lbnQgKHJ1bnRp
bWUgUE0pIHN1cHBvcnQuCgpUaGUgcHJldmlvdXMgc2VyaWVzICh2MSkgaGFzIGJlZW4gZGVwcmVj
YXRlZC4gV291bGQgaXQgYmUgbW9yZcKgCmFwcHJvcHJpYXRlIHRvIHNlbmQgdGhpcyBhcyB2MiBy
YXRoZXIgdGhhbiB2MTA/CgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDkw
NzE2MTI0Mi42NzE5MC0xLWJlbi5kb29rc0Bjb2RldGhpbmsuY28udWsvClsyXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzBiZGQ2YWI2LWJmZGQtNDAwZS05OWI2LWNmYjE4NmRmY2MzZUBj
b2RldGhpbmsuY28udWsvCgpUaGUgYmluZGluZyBmaWxlICdzbnBzLGR3LWFwYi10aW1lcnMtcHdt
Mi55YW1sJyBoYXMgYWxyZWFkeSBiZWVuIG1lcmdlZCzCoApidXQgdGhlIGN1cnJlbnQgZHJpdmVy
IGxhY2tzIHJlc2V0IHN1cHBvcnQuwqDCoApUaGVyZWZvcmUsIHBhdGNoIDEgYWRkcyBhbiBvcHRp
b25hbCByZXNldCBwcm9wZXJ0eSB0byBhZGRyZXNzIHRoaXMuCgpXZSB3aWxsIHVwZGF0ZSB0aGUg
Y29tbWl0IG1lc3NhZ2UgaW4gdGhlIG5leHQgdmVyc2lvbi4KCj4gPiAKPiA+IAo+ID4gCj4gPj4g
d2hpY2ggaXMgcG9zdGVkIGJ5IEJlbiBhbmQgc3RpbGwgdW5kZXIgcmV2aWV3LiAKPiA+PiBCYXNl
ZCBvbiB0aGlzIHBhdGNoLCB0aGlzIHNlcmllcyBpcyBhIGNvbnRpbnVhdGlvbiBvZiBbMV0gCj4g
Pj4gdG8gYWRkIHN1cHBvcnQgZm9yIElQIHZlcnNpb25zIDIuMTFhIGFuZCBsYXRlciwgd2hpY2gg
Cj4gPj4gaW5jbHVkZXMgc3VwcG9ydCBmb3IgIlB1bHNlIFdpZHRoIE1vZHVsYXRpb24gd2l0aCAw
JSAKPiA+PiBhbmQgMTAwJSBEdXR5IEN5Y2xlIi4KPiAKPiBCdXQgZG9lcyB0aGlzIG1lYW4gdGhl
IHBhdGNoc2V0IGNhbm5vdCBiZSBldmVuIHRlc3RlZD8KClN1cHBvcnQgZm9yIDAlIGFuZCAxMDAl
IGR1dHkgY3ljbGUgbW9kZSAoYXZhaWxhYmxlIGluIERlc2lnbldhcmUgUFdNIElQCnZlcnNpb24g
Mi4xMWEgYW5kIGxhdGVyKSBoYXMgYmVlbiB0ZXN0ZWQgb24gdGhlIEVJQzc3MDAgU29DLCB3aGlj
aAppbnRlZ3JhdGVzIElQIHZlcnNpb24gMi4xM2EuCgpGb3IgQmVuJ3MgaW1wbGVtZW50YXRpb24s
IHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgdGhpcyBtb2RlLCB0ZXN0aW5nIGNhbgpzdGlsbCBiZSBk
b25lIGJ5IHNldHRpbmcgZHdjLT5mZWF0dXJlcyB0byAwIGFmdGVyIHJlYWRpbmcgdGhlIHZlcnNp
b24KcmVnaXN0ZXIsIGVmZmVjdGl2ZWx5IGRpc2FibGluZyAwJSBhbmQgMTAwJSBkdXR5IGN5Y2xl
IHN1cHBvcnQuCgpSZWdhcmRzLApYdXlhbmcgRG9uZwo=

