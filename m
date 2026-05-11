Return-Path: <linux-pwm+bounces-8855-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA+gBm+YAWomfgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8855-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 10:50:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFB50A592
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1349230045A0
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207883BA25F;
	Mon, 11 May 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="LOsTO+eQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDcOPxMi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97F2D9ECA;
	Mon, 11 May 2026 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489436; cv=none; b=LD0wzNnYyXTlItAgYqaSK+WIi/uxymxVo72OAGaYz7qCLyuJyztc6DFu+hN88gzXod4JMYD/ly3ikL34ZJfUMOUfkprHrq1JLLl+Ixc/xucpwzudjlblg/hbtwMivL/ql655rz0xIlkhHFSqoR51QWNDtzUhy2eDS0Fmx8oTRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489436; c=relaxed/simple;
	bh=cRNS8O4aEUgVLd0JWYbG1HN1/tndkrWGyE6fOjt21b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EADM257oK3UesFwewvncPPscvOcgwReXoNmI0BFS5CbcGWQ3nemmvjws/ZjLVaIAamQR2ZCzGlFsn04piKXUjaKS7PWTZX+vtfpciNG8UEqkUlOp1hp1vFvNiWVGvjps54DNfZAY+lMbwagzAZsriY2ssecJk6oAQh0ABPhhy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=LOsTO+eQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDcOPxMi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 430FA7A00CE;
	Mon, 11 May 2026 04:50:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 11 May 2026 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778489432; x=1778575832; bh=jt9ibOwOB5
	ZgDpl28+OU1PXCAn8QfJTRE4dkW9Vb3BA=; b=LOsTO+eQtpe3r741xaLkVQzRQd
	qFVi7ShFZm3E9V4HVFTs2engBB1peCRCTkcsD0yraXQwlRMRKu4s6BvVSBH3pnAo
	lpXTkMOxwHc++Yu1ePbtlTaWQXmYPLe4znOEnY1PBhwhQ107noiprFPjxFsjWwzs
	MatNSiXRgMR0sSQVyPkamJdYyaSMl5YxRSPXYuXvfCWNEEHbROVwO3vTaReMABXJ
	X0gYjzJxzEi+1dlZuovbWAhXEiA0D2oxudPXC40mWUm4b19e7+iFx/40Fa3l3YvC
	yl57CbxbGqinwINz7roMlvZuOtsEWa0cVFu7NmeeTojctnKREDXtVBIWIR9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778489432; x=1778575832; bh=jt9ibOwOB5ZgDpl28+OU1PXCAn8QfJTRE4d
	kW9Vb3BA=; b=pDcOPxMiiP5ruo2XWMZgzDesICesNWrkVL88okIX5UV3Kt+RM2Y
	z5zSlB27DO1Mj8/6VZGL81Y2QIPQs+78SPS+aQg/rJTvgIGEsr8Q0iGkGQyvugKp
	2v5jYFBuAp6dkiTUy7bmJjN4L4jyXWQjMN3QJuAlfIxvMVKc+67e+QqXWaEeFnVl
	56dY+NJL2BJKGZF2i3Kmr7jk+yXva6vD9F1qmtubeWpLtCroJrtR2T8E3ZRIs7if
	PdiXC6DUIIjx97YhuQxrs3eb4N2l51zKPSxYN2/FrzkNoKxWLFRObaGXAWa8Icut
	gTPns1BTdlFdxPEwa35mnsqKYwalSxsPwRw==
X-ME-Sender: <xms:VpgBanUU0ztE6Rg-LnfF-nLj1cnzfS7IVx_pJfHwnrFunw2lLxjcVA>
    <xme:VpgBaniKE3NTpGwNZJ7FrgQTac17ZUp80KiEjJu-T9yLVtwm5PK87KWrfCVGw1aDE
    JeLWDinbwjVeGkuqSLAN8Ddva10mmyA4V5rcZf1j4boMlSC6OHV5Lst>
X-ME-Received: <xmr:VpgBaqnO_1mo6YLpCVnG5FVMhaiuWArMrQjGIVkhgDObhcOFK40MwaajL9o0Rf1jMVMgp-RV8DjBsvZTmUi22EQFtzOKq8Iwi7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgud
    euffelfeekgeeukedtheekjeettdfftddujefhvdehtefgiefgledtueefjeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedu
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquh
    hsrdhnvghtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhpihgvrhgrlhhishhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepfihimheslhhinhhugidqfigr
    thgthhguohhgrdhorhhgpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurd
    horhhg
X-ME-Proxy: <xmx:VpgBaowxRkzlJZKgC0vwY4hQTbKM6iO9ervrzIr7KLryQ_5A28NGLg>
    <xmx:VpgBatsyZlEk804I0LAQVVS7ia5EDKHFyp4-Pwjhw_6Lll0JE7F-MQ>
    <xmx:VpgBaluhzmo_aN5ikDHnpeRe43hbMSuaKNGZGj4O_BkZY4gVVXhBJA>
    <xmx:VpgBajlqNeNxTrn4oktYtSPno1O2oZ3jnjrBdX7XdqiF7qzUmQk8hA>
    <xmx:WJgBavb1dT_Lmt3FGxmTxuK4B-v82xNwO1Npg8Xu56yNR40CrKn5tpUQ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:50:30 -0400 (EDT)
Date: Mon, 11 May 2026 10:50:28 +0200
From: Janne Grunau <j@jannau.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
	Joshua Peisach <jpeisach@ubuntu.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Message-ID: <20260511085028.GA192358@robin.jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
 <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
 <85ea46a7-1136-4ea0-9eec-7dfa465df20b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85ea46a7-1136-4ea0-9eec-7dfa465df20b@roeck-us.net>
X-Rspamd-Queue-Id: A9FFB50A592
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8855-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,robin.jannau.net:mid,ubuntu.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jannau.net:email,jannau.net:dkim]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 08:29:39AM -0700, Guenter Roeck wrote:
> On Thu, May 07, 2026 at 09:33:08AM +0200, Janne Grunau wrote:
> > The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
> > existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
> > "apple,t8103-wdt" used by the driver.
> 
> '"apple,t8103-wdt" used by the driver' is not true. The watchdog driver
> only supports "apple,wdt".

It slipped my mind that
https://lore.kernel.org/linux-watchdog/20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net/
wasn't picked up yet.

> 
> > 
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> > index 05602678c070..845b5e8b5abc 100644
> > --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> > @@ -16,7 +16,9 @@ properties:
> >    compatible:
> >      oneOf:
> >        - items:
> > -          - const: apple,t6020-wdt
> > +          - enum:
> > +              - apple,t6020-wdt
> > +              - apple,t8122-wdt
> >            - const: apple,t8103-wdt
> >        - items:
> >            - enum:
> 
> I second Sashiko's findings that the driver will fail to bind because it
> only supports "apple,wdt". I would not mind and apply the patch anyway,
> but the statement in the description is just plain wrong and thus
> misleading. Please fix.

I would prefer if the addition of the "apple,t8103-wdt" to the driver is
picked.

Thanks,

Janne

