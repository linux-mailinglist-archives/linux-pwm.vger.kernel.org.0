Return-Path: <linux-pwm+bounces-8687-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APcbBkJG62m4KQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8687-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:30:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09A45D131
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B7D302DF5F
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDB363C50;
	Fri, 24 Apr 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqWxIIF8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E45305057;
	Fri, 24 Apr 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026409; cv=none; b=S0+dptC9cS+D3gy1bdrVIe9SkEG4x3qcu5n7Ix1GKYNesO5TtbXdCsnQ4e/65P19lJHq0a8jGZeaJFFbx0ndelLqwyX+GW0uRu7KXYT8OPdjqzJRC0K8HtFsRtmfu04yKNe4Ixn6XAhhehjSkjrtmotWXx1oWF5frTT+coxFNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026409; c=relaxed/simple;
	bh=6qdpYOEwgLxns6uy+l3iZ48fFOnItLJCDfEcMjKyDwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri8f8CIGBSqVdG0MnvZCOy50Kgsg9APHC9cog44+fiK3aH5/tur3VY4Hdwzs8IUs+oH909aGHWlHy0L+x6YlB6q8k1+5fY9JUGd/ubWuTdWuhYLd4ZjD0UqV8fdi6XW8lC3VP/relFrdfinWtcK1RxQntkrvynoaB634fwU+9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqWxIIF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FC1C19425;
	Fri, 24 Apr 2026 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026409;
	bh=6qdpYOEwgLxns6uy+l3iZ48fFOnItLJCDfEcMjKyDwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqWxIIF8IkQAlamNjybivRzR2oqo2uWMyT27bW2+eeH2feqVExPH6SkmOHTDCajrX
	 kwvzpt5dUfEDtlC2Iz8UEuhVw7GUIZibf26c+b8Tkj4HPiPa1tz2ZakERzglgXau+R
	 l9BJ+a4hKWVNpxMQazgIZEjDpAqHXs4zSm4tZ97xocyrAaDFhNisDEr4q4RDgBOjRv
	 r25ottLx3ENqpUsssrQtFYxFGtsbfd8vF2mmw30v/JsvrAcDzgruIaN9djKuNIbbdE
	 W9ZhmjycZ92cJW5v0kaZVoMEDcSCg7lREeic4LAfdeamPEQWkHfCMT2+ta+ZDKLysE
	 tyfw2DbIyn1cA==
Date: Fri, 24 Apr 2026 12:26:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] pwm: add support for Andes platform
Message-ID: <aetCpymy9iYE-wE-@monoceros>
References: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
 <aercn3iIcMvd3CPB@swlinux02>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dguxxe7wwxovvkw5"
Content-Disposition: inline
In-Reply-To: <aercn3iIcMvd3CPB@swlinux02>
X-Rspamd-Queue-Id: 7D09A45D131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8687-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url]


--dguxxe7wwxovvkw5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/3] pwm: add support for Andes platform
MIME-Version: 1.0

Hello Ben,

On Fri, Apr 24, 2026 at 10:59:43AM +0800, Ben Zong-You Xie wrote:
> Gentle ping on this series =E2=80=94 it's been ~4 weeks with no review on=
 the
> PWM side. Patch 1 (binding) has Conor's ack; patch 2 (driver) has not
> received any feedback yet.

Unfortunately there is a conflict between wanting to do a detailed
review and my time available for doing that. As long as your patch is
listed on https://patchwork.ozlabs.org/project/linux-pwm/list/ I havn't
forgotten about it and will review it when I find the time for it
(typically in a rough first-come-first-serve order, though I try to give
simpler and urgent patches a preference.)

So the obvious things you can do to speed up my processing are:

 - Look at the patches that are still before yours in the queue, find
   issues in them to kick them out of my queue :-)
 - With
   https://lore.kernel.org/all/7ia4o6kmpj5s.fsf@castle.c.googlers.com/
   in place since you sent your v5, feel free to send a v6 and look
   through the feedback by Sashiko. It's an AI and not specifically
   trained to the things I care about, so only adapt to the points where
   you agree. The feedback it provided for other series as far as I
   skimmed it contains some good points.

Best regards
Uwe

--dguxxe7wwxovvkw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnrRWMACgkQj4D7WH0S
/k5aZQgAq0AIXrRmD2GZhd1ZgZCcs8Sce1N/uQ23PAKGDmq2PmvAkcN9re7EZ2BV
4Pl9SEWKZw1U0eMAPjHO+WaQrL0A3WQPOph8Pyinp+93agUK9klK06/UnFyTlxJP
MmSE6BQKYYJUM61/1RgjnidWZdbvM9x9qd2W/0Fzoy77GcZA+aKv2Z2/NSIYoz1I
6C+OfF8QL2xv77rhDIbVRdbot8PxWE92nYB5WWt9sJrHwl0Nr6pt7wQc//JsLvGW
P9SqDo4GeR9jqLKLGTA6P97jeWISwMKazC05rC89TQTLdJU7hO0aVxE+Izyn3ZUj
Kvhmr07fSy5lUgx6//KgVHkFEXaYwA==
=gE+6
-----END PGP SIGNATURE-----

--dguxxe7wwxovvkw5--

