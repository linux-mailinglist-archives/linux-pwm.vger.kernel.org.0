Return-Path: <linux-pwm+bounces-9153-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /sOINOvlFGrdRAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9153-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 02:14:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FA5CF41E
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 02:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34F230180BE
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 00:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A931DFDE;
	Tue, 26 May 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RK2/hPLB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A3171AF
	for <linux-pwm@vger.kernel.org>; Tue, 26 May 2026 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754472; cv=none; b=nL86X9urql+jt+xK7SZxAMzgT2LJxXRtLZr5HERPfWRY3nSDtP2de3Uog1zUKkD7QlCbiVj8O4NvA/ix8kmkUYSoIf+hr/EBjEKDX85asJKXMRbcH5hDH+lg3u19OlVh3tuzds4MDWPihrk8EJoMcJXYLb6494jU2YuacNjCuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754472; c=relaxed/simple;
	bh=Vp7Jio/vsZh3XQA/CyPcX2F0P26k8s8Df1lXL0etR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMRiWSKdn+NEQav9lmyHiKQiEAa1c40RsxfrAfml81L3c83twnhLtp2O9OCX4kO2qMA1rjpktzzz/hf7jKyhFGTlNdGDZThrMPLewueUp0DORXYvLRvZLE47UshEeGpSB+jKhdX3Y3EwW1S/Mo80nzs2HStFJK4/A+iVV0fgGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RK2/hPLB; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-63133de7abcso3169527137.1
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2026 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779754469; x=1780359269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vp7Jio/vsZh3XQA/CyPcX2F0P26k8s8Df1lXL0etR6U=;
        b=RK2/hPLBt3yFcemvjXsMgxbPt4qgtPkKc4hF6ucExyy9r2Zr4btrsB7IdIsJHZEmcQ
         r6I+b/sJhMGdDqcdyAqHrdph6CN4/uOPM59dLNOiBONdsYP8uhkgzD0DTw4bXw9pj8jn
         QB1Ox5jDgz68LOuKu14QM8QMAXWt8uStcy20LZT6ZgpUNGbw/Hu8cGs20lT2ZC2nFLBv
         hQW5b6UHGjNuUTRfNn+hF4tqZPS0ywkykD/TDMUylBkpApnCUy/aVLqn8cDwihjylLJh
         aES9o9UcN1YKdgfkv2duWkeCXrMXp1fJMWXNMIS9/aWguAfqDC2vLRb9dx1ARNPQrZ+X
         Jc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779754469; x=1780359269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp7Jio/vsZh3XQA/CyPcX2F0P26k8s8Df1lXL0etR6U=;
        b=QOMkYcUIhEiuHj1vXFNml5yr0tcLUZx0LKVmeEF23t6PXR+65R9kNBmknvjQ1ffP/w
         /vubc7FM3oaGUrDucAdJVeYUU9XudD8YUNB7snMnGLOc0tDZHvuDcmlQj7VMW4b1otWD
         19jrKd4i6jGc/7gq28iML8xL7zcCnVog64zI1IU8czwVTaKaQTftPx7yGV5HTIbCICsA
         y7F+SmdFurjohhK2ZZp9G+/r9Ez2AYTXTQ/tIFbXTAjojGIXkpjZEj9nlT+JvM32/fEb
         5+id+yJgKruNkVEegb2Bew/NaPcZcu4vaIFl41lfQIBEcu4MRT5+rFCLg/OoSIPpIdps
         WUAg==
X-Gm-Message-State: AOJu0YzovdyzoW0K+Kqs943DLQ78h8hVzsqVIB0mlTY8eB53ff9WWQou
	9w9W/4b2wBQqO1GHICk6FmrEpVYIMFtD02DIdWh52q88NCyYR97432GT8WsBDkTgCKA=
X-Gm-Gg: Acq92OGacqSqPq4CAp4Nk+WsZ2Sm0yX5p+gTLA9XA/MPZV4BRWFQNQDoC7edsaBOTRq
	IsaJwAqr1pc8+HsELzM8VoYLTi8rrckbgkO0uNh16NKW5Lo5Y+meLCsYgCHB6rrXJtozBwIu5Eu
	SRtgNkdSJ+oA7SL6Ob3Cs3OPKaADOjg4rUXKba0y1dxkCgQ+vOdsVGgueCqXrV5bN6p94/DTnHW
	5zzt24S20oOJhP7TvpdhQXSl/4oFClEWoljuaBuijs/t9dUdK+zlHOExCXljyDd9uZ8BxdP4w1u
	2kqOZNi5cKTH5eBmmR6/qANWmBiqDlNH9iDA9Qc25Av6af3IiVQ1YvlWfK6WKy5MJI930q4e3tK
	fkfY7bWZZ6Jb2Hneotw5F9yIFwI8XYUbUOeS+5D3MHs21Pg9547sbwn1vBjGO068Z/rCs521dGh
	W+DZmlasTDMkqBjpLdJKk=
X-Received: by 2002:a05:6102:1494:b0:631:3b92:9dcc with SMTP id ada2fe7eead31-67c8398e867mr7695261137.27.1779754469441;
        Mon, 25 May 2026 17:14:29 -0700 (PDT)
Received: from acer-e1 ([2804:7f0:7542:d224:a24e:4c0b:adf1:58f4])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173b6d3a4sm12075526241.12.2026.05.25.17.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 17:14:29 -0700 (PDT)
Date: Mon, 25 May 2026 21:14:23 -0300
From: Ronaldo Nunez <rnunez@baylibre.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx27: Fix variable truncation in .apply()
Message-ID: <ahTl3xm1qkDPYxVv@acer-e1>
References: <20260522191348.6227-1-rnunez@baylibre.com>
 <ahHV_GIwdWvTu-ms@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahHV_GIwdWvTu-ms@monoceros>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,pengutronix.de,gmail.com,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9153-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rnunez@baylibre.com,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A1FA5CF41E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On Sat, May 23, 2026 at 06:55:40PM +0200, Uwe Kleine-König wrote:
> . I haven't made up my mind if I create another pull request to get the
> patches from the pwm/fixes branch into 7.1. If not, it will go into
> 7.2-rc1.

Sounds good, thanks.

> Sashiko found a few more issues in the imx27 driver, would you like to
> address these, too?

Yes, I'm already taking a look on those issues.

Best,
Ronaldo

