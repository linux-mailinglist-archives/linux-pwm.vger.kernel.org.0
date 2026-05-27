Return-Path: <linux-pwm+bounces-9173-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hYaXErvzFmquygcAu9opvQ
	(envelope-from <linux-pwm+bounces-9173-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:38:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2645E5188
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 606EC308FCEA
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01240DFA5;
	Wed, 27 May 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4ZoD6+J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9530F80C
	for <linux-pwm@vger.kernel.org>; Wed, 27 May 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888252; cv=none; b=Hxshkl9Pw7aROTWqpltHMj1sBdPVTxp5uzVDB3cszyBqVLLisq3VUImyri9WJjH7j12MteaVNeo26+rUo4vRr+kXY8lAFBtIxuWL1oLopvamGPzkCBXZZmGeC7PPqbMCyRh9f5PhET4TM2Pv6dsZGBu7sllXsyKMKJ22dvihfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888252; c=relaxed/simple;
	bh=ynx0YVdRpScOcVOUl3nY0Y9gWTKj9Ts8mNFO+WkHlNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pu0vDn6X16vb7vDzT1QLUHIlm3E4nTePPA93JVKSHsF+rmfRbjGVztujP+souA4SZHnfR3o/pELR0/mf7l9ZFuNgbnAd06qhItP7G1sEXyDRB5Y10XSJU4aCqHxRPfgSocG6ThnxPcSyC5A32QAXOPH/lQ6ta/ne5h+lJki0z1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4ZoD6+J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44081F0155D
	for <linux-pwm@vger.kernel.org>; Wed, 27 May 2026 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888250;
	bh=ynx0YVdRpScOcVOUl3nY0Y9gWTKj9Ts8mNFO+WkHlNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M4ZoD6+JXZamGLbvvzX/8mFPVFodp59z3BYZHOJ1maZT37ITWJ1ws8ONO9jIbUftd
	 LhBznDJJWgJ/U3q/e786ivP8rwVQtbr3RJRmy6qBsz0ICUZOKF6QS/jIpX3pL85Hki
	 SBmpqnhbtAvifobPfoWvZGlHFvxvtwHbn014qxWtP3eC7ft5ucRqNyM7sDgcHxJLzZ
	 CjuHGcMnd1dOC7Ya72IC7X4enemClLRXmDi8GBQi7DjBa5i3d4hQ/BgtcnHmfcskwr
	 iSmD9SSLkwPopili/8IrKg0QYxQQW1DIGqW3wIH4gZu6D00pC5ZOrV7RLY/I77dU83
	 JWF0LkIvryJTQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a4113ab355so6629882e87.1
        for <linux-pwm@vger.kernel.org>; Wed, 27 May 2026 06:24:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ZurGpy7hpG2R4DJ51xulk8io8WhaYgePBJxKHwg9882yZ88Dcqgl+czUCgThDSd47wB2FszypOcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+t5PpxPngp8yF2/J+kQmubS3h4WIZ26FLja8Y5iYSJWqaKMD
	bHRupwLR80D+F+PqCKERNNBRt8uw7EYeONzdyaUYUX0KGane2V0JW8E9L7EHrvk2po3bPIycANP
	pQxf+Rz9s+8D/Yv8HvqZRI+nP5bO4O4c=
X-Received: by 2002:a05:6512:31c4:b0:5a8:7317:5417 with SMTP id
 2adb3069b0e04-5aa32369f4amr7061708e87.9.1779888249425; Wed, 27 May 2026
 06:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508184626.15938-1-manishbaing2789@gmail.com>
In-Reply-To: <20260508184626.15938-1-manishbaing2789@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 15:23:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLk0QWoTCXEqZbm_ECV2YQdL6PBZp2+EMSVH6DrmPx=dKw@mail.gmail.com>
X-Gm-Features: AVHnY4LJ4ZgmIO12q-22xaSmmAdfwCpy1pxkuhOelzvqfy6Ynt81zGPLoHbXLKo
Message-ID: <CAD++jLk0QWoTCXEqZbm_ECV2YQdL6PBZp2+EMSVH6DrmPx=dKw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pwm: stmpe: drop legacy binding
To: Manish Baing <manishbaing2789@gmail.com>
Cc: ukleinek@kernel.org, thierry.reding@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9173-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4B2645E5188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 8, 2026 at 8:46=E2=80=AFPM Manish Baing <manishbaing2789@gmail.=
com> wrote:

> The st,stmpe-pwm binding is already covered by the MFD schema
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. Remove the
> obsolete and redundant text binding file.
>
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

If the PWM maintainer is busy maybe Rob can queue this patch?

Yours,
Linus Walleij

