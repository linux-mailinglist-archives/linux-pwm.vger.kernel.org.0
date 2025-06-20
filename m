Return-Path: <linux-pwm+bounces-6452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88126AE109C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 03:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FEA17ADBB
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D5288D6;
	Fri, 20 Jun 2025 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBJ6LI+z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063F2F2E;
	Fri, 20 Jun 2025 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382093; cv=none; b=W9VSyWLZAnJi48UrXNi3TGDRPdn2Zo/jkM/A5BC0tnLFAxx9TrLXmVXGWg61sa924aGBEQzxC98Se2wQ6bURNzXdgVbisVJ6Oq6xjL8rMKJrh5jGg4tmKHo6l7TtTbIGBGtYNb/e3KldErNrkgsXpiGgLG01dTWiHM6QzYU/+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382093; c=relaxed/simple;
	bh=McRy9I0u6F3rMvUrWVKTsRhk1SC1lYv0enna54dykdw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mREvAfGGRwOCXki8qh74zkyGsK0PDlMrTuW3cljZ3tugFhNMg297MOnsXzNuGZ26HXWK0v9YgQ2hojxKk/gBQzhEAX7gQ8lo5tun6b8p/UbBuoyiQTEXQUlPJMO4NObjsOZsGVNEuk6GskA+u1euDwllyUJ7hY+dJPU6YheBNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBJ6LI+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B8CC4CEEA;
	Fri, 20 Jun 2025 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750382093;
	bh=McRy9I0u6F3rMvUrWVKTsRhk1SC1lYv0enna54dykdw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vBJ6LI+zmsCCxHnoH/XkizPFoZp6mVfL0jxEhaBPe0ClP71Jp9b3U8XdJO1UJDPq4
	 RkdFJAWeB1kwX4bs9hkmM1Igk++BZ1pJqKaFFXO5RUpUPejTgDkhUYridnri6xdz8o
	 c4T95TeGbywXArkRjyyrFZ6rkhONJs7nMx0wvEs+yohdB73vAbrnVacavC4lKB/HkL
	 +zySWU+kjVnwDKHNtE7UNEzkcJxCrvtDmskvOBmF+X1s4BI0JGp+49BYWBCk7yf8al
	 qujisIOkjPVovWLJev5u3iIhZ5ghtTTEi/YYNynaxTfybciyp84xD3ETFDWdI0Z1NC
	 kIFIvtxtDuDYA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a974f1147e1a080bf5ad7f1752c92b24516df284.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com> <a974f1147e1a080bf5ad7f1752c92b24516df284.1746006578.git.ukleinek@baylibre.com>
Subject: Re: [PATCH 3/4] clk: pwm: Don't reconfigure running PWM at probe time
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Thu, 19 Jun 2025 18:14:52 -0700
Message-ID: <175038209259.4372.10203590037146296279@lazor>
User-Agent: alot/0.11

Quoting Uwe Kleine-K=C3=B6nig (2025-04-30 02:57:48)
> If the PWM is enabled already when .probe() is entered, period and
> duty_cycle are updated which essentially corresponds to a clock frequency
> change. This is unusual and surprising. So update the settings only when
> the clock gets prepared.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Applied to clk-next

