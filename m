Return-Path: <linux-pwm+bounces-8606-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEdRBjCv4GkRkwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8606-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 11:43:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A454940C895
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 11:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E411F3014648
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549ED39A077;
	Thu, 16 Apr 2026 09:39:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CF394789;
	Thu, 16 Apr 2026 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332370; cv=none; b=SnnPILzjCyBoa7IZtM7GlAJzkXzlqjtqvzVrg6U95Ps6osUFzZ6f9MKTDKCMjCblufA6NSecy9WvrL7G9Cyt2TsQ+PO4M4QjcU+h3Vw3qDHmQRixA8VfKRtPJHeeG5q7uP92q2AspOY1Ji3+VxSkdJAhglTELumxE2nZvq5mZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332370; c=relaxed/simple;
	bh=T7CoLB2p6sG/di7D5Nmfq3bgVGiqmIyvmGldLZWNe50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=M9qq3iM5dkIMjQokcsHcEpoh4ewjmu7eQeYwVhh4nHJ7WfRMb6bO+8CX5VPY0QIpiZLM1YNgWxfzMH6eu5mp0K1NGbVPZyp41gAz3y/6Vf87m8fIapfYt4XDoPcpBWfozIdc/c5ODdWxzU0rzW+Xnr5g+7MMqVhkHQ6XBkdtmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 16 Apr 2026 17:38:59 +0800 (GMT+08:00)
Date: Thu, 16 Apr 2026 17:38:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>,
	"Conor Dooley" <conor@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260416-wandering-solemn-uakari-083ae7@quoll>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <20260415-reacquire-handstand-d1923af82c9d@spud>
 <20260416-wandering-solemn-uakari-083ae7@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <281f7aa3.5575.19d95a879f8.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ8zruBp7yYSAA--.2351W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgETAmnfvg1VQ
	QAAsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
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
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8606-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:mid,eswincomputing.com:email]
X-Rspamd-Queue-Id: A454940C895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+ID4gCj4gPiA+IFRoZSBEZXNpZ25XYXJlIFBXTSBpbmNsdWRlcyBzZXBhcmF0ZSByZXNldCBz
aWduYWxzIGRlZGljYXRlZCB0byBlYWNoIGNsb2NrCj4gPiA+IGRvbWFpbjoKPiA+ID4gVGhlIHBy
ZXNldG4gc2lnbmFsIHJlc2V0cyBsb2dpYyBpbiBwY2xrIGRvbWFpbi4KPiA+ID4gVGhlIHRpbWVy
X05fcmVzZXRuIHNpZ25hbCByZXNldHMgbG9naWMgaW4gdGhlIHRpbWVyX05fY2xrIGRvbWFpbi4K
PiA+ID4gVGhlIHJlc2V0cyBhcmUgYWN0aXZlLWxvdy4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IAo+ID4g
VGhpcyBjb21taXQgaW1wbGllcyB0aGF0IHlvdXIgaGFyZHdhcmUgZGlmZmVycyBmcm9tIGV4aXN0
aW5nIGRldmljZXMsCj4gPiBJIHRoaW5rIHlvdSBzaG91bGQgYWRkIGEgZGV2aWNlLXNwZWNpZmlj
IGNvbXBhdGlibGUuCj4gPiAKCkhpIENvbm9yIGFuZCBLcnp5c3p0b2YsCgpUaGUgRGVzaWduV2Fy
ZSBQV00gRGF0YWJvb2sgZm9yIDIuMTNhIHNheXM6ICJUaGUgRFdfYXBiX3RpbWVycyBpbmNsdWRl
c8KgCnNlcGFyYXRlIHJlc2V0IHNpZ25hbHMgZGVkaWNhdGVkIHRvIGVhY2ggY2xvY2sgZG9tYWlu
Ii4gVGhleSBhcmU6ClRoZSBwcmVzZXRuIHNpZ25hbCByZXNldHMgbG9naWMgaW4gcGNsayBkb21h
aW4gKGkuZS4sIHRoZSBidXMgY2xvY2sgaW4gRFQpLgpUaGUgdGltZXJfTl9yZXNldG4gc2lnbmFs
IHJlc2V0cyBsb2dpYyBpbiB0aGUgdGltZXJfTl9jbGsgZG9tYWluIChpLmUuLAp0aGUgdGltZXIg
Y2xvY2sgaW4gRFQpLgoKVGhlc2UgcmVzZXQgc2lnbmFscyBhcmUgb3B0aW9uYWw7IGl0IGlzIHVw
IHRvIHRoZSBkZXNpZ25lcidzIAppbXBsZW1lbnRhdGlvbi4KCkFjY29yZGluZyB0byBbMV0sIHRo
ZSBhcHBsaWVkIFlBTUwgaXMgYWxzbyBiYXNlZCBvbiAyLjEzYSwgc28gb3VywqAKaGFyZHdhcmUg
aXMgdGhlIHNhbWUgYXMgdGhlIGV4aXN0aW5nIGRldmljZXMuIEl0J3MganVzdCB0aGF0IHRoZXNl
IHR3b8KgCnJlc2V0IHNpZ25hbHMgd2VyZSBtaXNzaW5nIGZyb20gdGhlIG9yaWdpbmFsIFlBTUwg
YmluZGluZy4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wd20vOGJiNTEwM2Qt
ODAzZS05MGQyLWZkOTMtMTMyYmIyYWFjMmQ2QHNpZml2ZS5jb20vCgo+ID4gPiAtLS0KPiA+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1s
ICAgICAgIHwgMyArKysKPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiA+
ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cHdtL3NucHMsZHctYXBiLXRpbWVycy1wd20yLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL3NucHMsZHctYXBiLXRpbWVycy1wd20yLnlhbWwKPiA+ID4gaW5kZXgg
NzUyM2E4OWExNzczLi5hOGJiYWQwMzYwZjggMTAwNjQ0Cj4gPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbAo+
ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3NucHMsZHct
YXBiLXRpbWVycy1wd20yLnlhbWwKPiA+ID4gQEAgLTQzLDYgKzQzLDkgQEAgcHJvcGVydGllczoK
PiA+ID4gICAgICAgIC0gY29uc3Q6IGJ1cwo+ID4gPiAgICAgICAgLSBjb25zdDogdGltZXIKPiA+
ID4gIAo+ID4gPiArICByZXNldHM6Cj4gPiA+ICsgICAgbWF4SXRlbXM6IDIKPiAKPiBBbmQgdGhp
cyBzaG91bGQgcmVhbGx5IGJlIGxpc3RlZCB3aXRoIGRlc2NyaXB0aW9uLCBiZWNhdXNlIG9yZGVy
IGlzCj4gZml4ZWQuCj4gCgpUaGUgZGVzY3JpcHRpb24gb2YgcmVzZXRzIHdpbGwgYmUgbGlzdGVk
IGluIG5leHQgdmVyc2lvbi4KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcK

