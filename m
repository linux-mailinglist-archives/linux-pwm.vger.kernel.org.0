Return-Path: <linux-pwm+bounces-8625-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI+FHBul4WnjwAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8625-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 05:12:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5052416783
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 05:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6367A301FA80
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644630B502;
	Fri, 17 Apr 2026 03:12:23 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109C3B2AA;
	Fri, 17 Apr 2026 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395543; cv=none; b=h/QtHG/CW1VsHYW9wqaAhe7qttY5Y3hwdTWMAKza8yvkDxmxIvvTfEXMiTpWDEBVnPE8wnCwDPmPnGz+A/51k5NNYNBIvrpvKv7ssr/eI3CqSPOyi2cA4iigsZwdiz/BeVXUdcp4L1obAjZOrw9iP9r1psIeHwZGiT1GChfc1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395543; c=relaxed/simple;
	bh=kqBVNGwxpKB1stgn4t21+OlgFdmZqmq8qQ6qKFQWzNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tz53W+ER2jWS8OnPzCLipwYbKAy3FToqGTZXDdXE7DNs3toBOFxIlBk54N+a+r5iaq8CTEiz6ipmvE7hizwFHQNv6agEleV78PgBvw/RQwfkEFrjljS3lYxBH91qU4R7LfkWoTvzfEc17Q3+kY/4cH3D+eQ8Q9i9xKjNeczjFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 17 Apr 2026 11:11:51 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 11:11:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Conor Dooley" <conor@kernel.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, ukleinek@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset
 optional
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260416-flashcard-shadily-a0ddd2f12ff8@spud>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <20260415-reacquire-handstand-d1923af82c9d@spud>
 <20260416-wandering-solemn-uakari-083ae7@quoll>
 <281f7aa3.5575.19d95a879f8.Coremail.dongxuyang@eswincomputing.com>
 <20260416-flashcard-shadily-a0ddd2f12ff8@spud>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3b2e80d5.55a5.19d996c6821.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ_3pOFp21YSAA--.2378W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEAAmnhD40Rb
	QAAs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8625-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.359];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,eswincomputing.com:mid,eswincomputing.com:email]
X-Rspamd-Queue-Id: B5052416783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhlIERlc2lnbldhcmUgUFdNIGluY2x1ZGVzIHNlcGFyYXRl
IHJlc2V0IHNpZ25hbHMgZGVkaWNhdGVkIHRvIGVhY2ggY2xvY2sKPiA+ID4gPiA+IGRvbWFpbjoK
PiA+ID4gPiA+IFRoZSBwcmVzZXRuIHNpZ25hbCByZXNldHMgbG9naWMgaW4gcGNsayBkb21haW4u
Cj4gPiA+ID4gPiBUaGUgdGltZXJfTl9yZXNldG4gc2lnbmFsIHJlc2V0cyBsb2dpYyBpbiB0aGUg
dGltZXJfTl9jbGsgZG9tYWluLgo+ID4gPiA+ID4gVGhlIHJlc2V0cyBhcmUgYWN0aXZlLWxvdy4K
PiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHV5YW5nIERvbmcgPGRvbmd4dXlh
bmdAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgY29tbWl0IGltcGxp
ZXMgdGhhdCB5b3VyIGhhcmR3YXJlIGRpZmZlcnMgZnJvbSBleGlzdGluZyBkZXZpY2VzLAo+ID4g
PiA+IEkgdGhpbmsgeW91IHNob3VsZCBhZGQgYSBkZXZpY2Utc3BlY2lmaWMgY29tcGF0aWJsZS4K
PiA+ID4gPiAKPiA+IAo+ID4gSGkgQ29ub3IgYW5kIEtyenlzenRvZiwKPiA+IAo+ID4gVGhlIERl
c2lnbldhcmUgUFdNIERhdGFib29rIGZvciAyLjEzYSBzYXlzOiAiVGhlIERXX2FwYl90aW1lcnMg
aW5jbHVkZXPCoAo+ID4gc2VwYXJhdGUgcmVzZXQgc2lnbmFscyBkZWRpY2F0ZWQgdG8gZWFjaCBj
bG9jayBkb21haW4iLiBUaGV5IGFyZToKPiA+IFRoZSBwcmVzZXRuIHNpZ25hbCByZXNldHMgbG9n
aWMgaW4gcGNsayBkb21haW4gKGkuZS4sIHRoZSBidXMgY2xvY2sgaW4gRFQpLgo+ID4gVGhlIHRp
bWVyX05fcmVzZXRuIHNpZ25hbCByZXNldHMgbG9naWMgaW4gdGhlIHRpbWVyX05fY2xrIGRvbWFp
biAoaS5lLiwKPiA+IHRoZSB0aW1lciBjbG9jayBpbiBEVCkuCj4gPiAKPiA+IFRoZXNlIHJlc2V0
IHNpZ25hbHMgYXJlIG9wdGlvbmFsOyBpdCBpcyB1cCB0byB0aGUgZGVzaWduZXIncyAKPiA+IGlt
cGxlbWVudGF0aW9uLgo+IAo+IFJpZ2h0LCBhbmQgaXQncyB0aGF0ICJkZXNpZ25lcidzIGltcGxl
bWVudGF0aW9uIiB0aGF0IHdhcnJhbnRzIGEKPiBkZXZpY2Utc3BlY2lmaWMgY29tcGF0aWJsZS4K
PiAKCkhpIENvbm9yLAoKVGhlIFlBTUwgdXBkYXRlIGZvciB0aGUgbmV3IGRldmljZS1zcGVjaWZp
YyBjb21wYXRpYmxlIGlzIGFzIGZvbGxvd3M6Cgpwcm9wZXJ0aWVzOgogIGNvbXBhdGlibGU6CiAg
ICBvbmVPZjoKICAgICAgLSBjb25zdDogc25wcyxkdy1hcGItdGltZXJzLXB3bTIKICAgICAgLSBp
dGVtczoKICAgICAgICAgIC0gZW51bToKICAgICAgICAgICAgICAtIHNucHMsZHctYXBiLXRpbWVy
cy1wd20tMi4xM2EKICAgICAgICAgIC0gY29uc3Q6IHNucHMsZHctYXBiLXRpbWVycy1wd20yCgog
IHJlZzoKICAgIG1heEl0ZW1zOiAxCgogICIjcHdtLWNlbGxzIjoKICAgIGNvbnN0OiAzCgogIGNs
b2NrczoKICAgIGl0ZW1zOgogICAgICAtIGRlc2NyaXB0aW9uOiBJbnRlcmZhY2UgYnVzIGNsb2Nr
CiAgICAgIC0gZGVzY3JpcHRpb246IFBXTSByZWZlcmVuY2UgY2xvY2sKCiAgY2xvY2stbmFtZXM6
CiAgICBpdGVtczoKICAgICAgLSBjb25zdDogYnVzCiAgICAgIC0gY29uc3Q6IHRpbWVyCgogIHJl
c2V0czoKICAgIGl0ZW1zOgogICAgICAtIGRlc2NyaXB0aW9uOiBJbnRlcmZhY2UgYnVzIHJlc2V0
CiAgICAgIC0gZGVzY3JpcHRpb246IFBXTSB0aW1lciBsb2dpYyByZXNldAoKICBzbnBzLHB3bS1u
dW1iZXI6CiAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIK
ICAgIGRlc2NyaXB0aW9uOiBUaGUgbnVtYmVyIG9mIFBXTSBjaGFubmVscyBjb25maWd1cmVkIGZv
ciB0aGlzIGluc3RhbmNlCiAgICBlbnVtOiBbMSwgMiwgMywgNCwgNSwgNiwgNywgOF0KCnJlcXVp
cmVkOgogIC0gY29tcGF0aWJsZQogIC0gcmVnCiAgLSBjbG9ja3MKICAtIGNsb2NrLW5hbWVzCgph
bGxPZjoKICAtICRyZWY6IHB3bS55YW1sIwoKICAtIGlmOgogICAgICBwcm9wZXJ0aWVzOgogICAg
ICAgIGNvbXBhdGlibGU6CiAgICAgICAgICBjb250YWluczoKICAgICAgICAgICAgY29uc3Q6IHNu
cHMsZHctYXBiLXRpbWVycy1wd20tMi4xM2EKCiAgICB0aGVuOgogICAgICByZXF1aXJlZDoKICAg
ICAgICAtIHJlc2V0cwoKSW4geW91ciBvcGluaW9uLCBpcyB0aGlzIG1vZGlmaWNhdGlvbiBhY2N1
cmF0ZT8KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcKCj4gPiAKPiA+IEFjY29yZGluZyB0byBb
MV0sIHRoZSBhcHBsaWVkIFlBTUwgaXMgYWxzbyBiYXNlZCBvbiAyLjEzYSwgc28gb3VywqAKPiA+
IGhhcmR3YXJlIGlzIHRoZSBzYW1lIGFzIHRoZSBleGlzdGluZyBkZXZpY2VzLiBJdCdzIGp1c3Qg
dGhhdCB0aGVzZSB0d2/CoAo+ID4gcmVzZXQgc2lnbmFscyB3ZXJlIG1pc3NpbmcgZnJvbSB0aGUg
b3JpZ2luYWwgWUFNTCBiaW5kaW5nLgo+ID4gCj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtcHdtLzhiYjUxMDNkLTgwM2UtOTBkMi1mZDkzLTEzMmJiMmFhYzJkNkBzaWZpdmUu
Y29tLwo+ID4gCj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9wd20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbCAgICAgICB8IDMgKysrCj4gPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3
LWFwYi10aW1lcnMtcHdtMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiA+ID4gPiBpbmRleCA3NTIzYTg5
YTE3NzMuLmE4YmJhZDAzNjBmOCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbAo+ID4g
PiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3
LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiA+ID4gPiBAQCAtNDMsNiArNDMsOSBAQCBwcm9wZXJ0
aWVzOgo+ID4gPiA+ID4gICAgICAgIC0gY29uc3Q6IGJ1cwo+ID4gPiA+ID4gICAgICAgIC0gY29u
c3Q6IHRpbWVyCj4gPiA+ID4gPiAgCj4gPiA+ID4gPiArICByZXNldHM6Cj4gPiA+ID4gPiArICAg
IG1heEl0ZW1zOiAyCj4gPiA+IAo+ID4gPiBBbmQgdGhpcyBzaG91bGQgcmVhbGx5IGJlIGxpc3Rl
ZCB3aXRoIGRlc2NyaXB0aW9uLCBiZWNhdXNlIG9yZGVyIGlzCj4gPiA+IGZpeGVkLgo+ID4gPiAK
PiA+IAo+ID4gVGhlIGRlc2NyaXB0aW9uIG9mIHJlc2V0cyB3aWxsIGJlIGxpc3RlZCBpbiBuZXh0
IHZlcnNpb24uCj4gPiAKPiA+IEJlc3QgcmVnYXJkcywKPiA+IFh1eWFuZyBEb25nCg==

