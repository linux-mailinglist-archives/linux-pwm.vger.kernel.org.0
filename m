Return-Path: <linux-pwm+bounces-8626-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCElFYOl4WknwQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8626-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 05:14:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9394167A1
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 05:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75620304CA78
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 03:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B72EA48F;
	Fri, 17 Apr 2026 03:14:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BD199D8;
	Fri, 17 Apr 2026 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395646; cv=none; b=sPxKXvjj5x2zwedxp1arwjdZ3xNmtbQahCYw30V3oJYRcPIYn8BLj8yZwNNrjw2oYwb+r3UOr4wL0vJhUt33rE4AaTbdq/4+R7yxy7If5IDzfc5+LnDZQ51bwR8Q3HjRe8Qv2DSPv+CmZChrYE4QCswg+CwZ6iOj+cUowG4w3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395646; c=relaxed/simple;
	bh=XlKAvBAxYI1INKbsNGmDVyjKLC/0zmoT5vwxHS3s6O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=knZKfmll9PIXFHnSde5wyP/v4FsnFPUgF2qbDXnYsYB11tdvPINoIJ3Qau73znImO/QK1gUimIHzLbOvazjEG8PJDIyGicofxzyc9QpeaoZOtRBT3EIPOURKDIzjheknTKBGxd9w+DhV8YC1NIfCPE+e+z3sePFeO2qirKCDscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 17 Apr 2026 11:13:52 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 11:13:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
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
In-Reply-To: <aeE-D5vC453uqtm6@monoceros>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <aeE-D5vC453uqtm6@monoceros>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <65568985.55a7.19d996e40c9.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqFwpeFp31YSAA--.4352W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEAAmnhD40Rb
	QABs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8626-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:mid]
X-Rspamd-Queue-Id: CD9394167A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAKPiBIZWxsbywKPiAKPiBJIHN1Z2dlc3QKPiAKPiAJZHQtYmluZGluZ3M6IHB3bTogZHdjOiBB
ZGQgb3B0aW9uYWwgcmVzZXQKPiAKPiBhcyBzaG9ydGxvZy4KPiAKCkhpIFV3ZSwKClRoYW5rcywg
SSdsbCBhZGRyZXNzIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4KCkJlc3QgcmVnYXJkcywKWHV5
YW5nIERvbmcK

