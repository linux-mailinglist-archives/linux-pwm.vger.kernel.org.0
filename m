Return-Path: <linux-pwm+bounces-9021-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJsFKH5hDGpXggUAu9opvQ
	(envelope-from <linux-pwm+bounces-9021-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:11:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A557F589
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44FEF30BBCDE
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F93403F2;
	Tue, 19 May 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFAci2d8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E313403E3;
	Tue, 19 May 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195790; cv=none; b=Qi+OZ4eyzXwfhvWApI6SFQ/tjpBBrgHdPtqdc2nPXfC3USdAxzE/qerh8WqyanvM3rpDL/qG9TjXthSKoElZLoGnAZfKdIKdqz/Ss1Sy5hgsOIY9Y9AB0dfxKJUqxZsPj4GBV7p5Bz0STv2Rz8oGBvRmXse7GQq06KElAUVTluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195790; c=relaxed/simple;
	bh=+C2REwytvDpqdC7fpylSr1kFZZwJ6+smFl9XkzZoNGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=O8/oj216J53RCqiB1bq+XruXTQjmAbj4EF9jVe+guUW8MJXRHFdf1pU1yxTJqDrhMQAKLaPqlLxooJF0x6XhW3JCiO/YO8sLST6nOAYdNxgiz5ZPFMC58gfwP6mdxta1ZvN7sqRqSadRKSq4tlfl4optL5qDBVXoQqPHzXFnPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFAci2d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FEEC2BCB3;
	Tue, 19 May 2026 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779195790;
	bh=+C2REwytvDpqdC7fpylSr1kFZZwJ6+smFl9XkzZoNGk=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ZFAci2d8oxkEgzfKQypntDGC4/3sOl/EZD/Cif7IJcuE7YJmmxxvopoVOP513Ofvs
	 YqZUHh6U76CV6qrXtkZmNjzwIC+TqPB/8rn1VBqRcmhDD6BuAREpNZhWHyaiV0ntSA
	 EEa2w+3k32v9tDTHdL/35qponLjn3dwNCS+pWF/LekRMX/aktpdkLIlUYU8q3eWATc
	 CTcujhS70SxHn6HZQ6zFOLTQ0QvyyhRJmPj3zyE2XiTzL7nCJ3J4ozxFuJnBCGei8O
	 QUoBU8WAwJ347ud+tCTWDQab54U41ELMrzpY3F1iyjs7+E1rWk4Ni+0+jsd8zjgRj8
	 EOFP+ednMG2HA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:03:02 +0200
Message-Id: <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com>
 <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
In-Reply-To: <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9021-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 237A557F589
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 1:39 PM CEST, Gary Guo wrote:
> Danilo, what do you think?

Two thoughts about this:

  (1) The blast radius is bigger than just auxiliary device registrations; =
this
      pattern is applicable to all kinds of registrations that provide the
      guarantee to be scoped to the bus device being bound. I.e. it is true=
 for
      any class device registration, IRQ registration, etc. They should all
      support HRT eventually; there is a subsequent series where I started =
to
      implement this for DRM.

  (2) I'm not concerned about the UnsafeForLtImpl approach, as I think for =
a
      human one would really need to be willing to abuse it by intention. I=
.e.
      it is not really different to just using unsafe {} while knowing not =
to be
      able to satisfy the safety requirement.

      That said, I expect LLMs to be (heavily) used to write drivers, and L=
LMs
      are typically trained to be compliant. So, I could imagine that a pro=
mpt
      along the lines of "Can't we make this work without unsafe somehow?" =
leads
      to an LLM abusing this, while going unnoticed for the user.

That said, I think that requiring define_for_lt!() wouldn't be that big of =
an
issue; the number of registrations per driver is rather limited.

Besides that, considering (2) it may actually address a practical concern.

If you want to make the change I'm happy to integrate it in a v4, otherwise=
 a
follow-up seems reasonable as well.

