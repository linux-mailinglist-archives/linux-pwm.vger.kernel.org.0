Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2468B1A7746
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437616AbgDNJYl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 05:24:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437562AbgDNJYk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 05:24:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOHni-0006IQ-5p; Tue, 14 Apr 2020 11:24:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOHng-00052J-E5; Tue, 14 Apr 2020 11:24:12 +0200
Date:   Tue, 14 Apr 2020 11:24:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-pwm@vger.kernel.org, od@zcrc.me,
        Artur Rojek <contact@artur-rojek.eu>,
        Mathieu Malaterre <malat@debian.org>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-clk@vger.kernel.org
Subject: Re: About rounding in the clk framework [Was: Re: [PATCH 4/7] pwm:
 jz4740: Improve algorithm of clock calculation]
Message-ID: <20200414092412.scsl6sekikc2tsv5@pengutronix.de>
References: <1565648183.2007.3@crapouillou.net>
 <20190813052726.g37upws5rlvrszc4@pengutronix.de>
 <1565694066.1856.1@crapouillou.net>
 <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
 <1565700448.1856.2@crapouillou.net>
 <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
 <1565799035.1984.0@crapouillou.net>
 <20190814173218.zhg4se3pppano5m3@pengutronix.de>
 <1571662077.3.1@crapouillou.net>
 <20200212072911.nstwj7dgpvceebpy@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212072911.nstwj7dgpvceebpy@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Stephen, hello Michael,

On Wed, Feb 12, 2020 at 08:29:11AM +0100, Uwe Kleine-König wrote:
> Can you please explain what is the reason why clk_round_rate_up/down()
> is a bad idea? Would it help to create a patch that introduces these
> functions to get the discussion going?

I didn't get any feedback on my mail. Are you to busy working on more
important stuff? Is the answer so obvious that you don't consider it
worth your time to answer?

Looking a bit through the code I see there are two callbacks hwclks can
provide to implement rounding (determine_rate and round_rate). The docs
for both use the term "return the closes rate actually supported". Does
that mean "round-closest" is already the official policy and other
strategies in lowlevel drivers are a bug?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
