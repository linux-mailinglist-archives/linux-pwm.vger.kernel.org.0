Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52514C7F9
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jan 2020 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgA2JYU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jan 2020 04:24:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37659 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JYT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jan 2020 04:24:19 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iwja6-0007pI-Kw; Wed, 29 Jan 2020 10:24:18 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iwja6-0007kA-BI; Wed, 29 Jan 2020 10:24:18 +0100
Date:   Wed, 29 Jan 2020 10:24:18 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] docs: pwm: rework documentation for the framework
Message-ID: <20200129092418.a7vbz37uzloyfmdc@pengutronix.de>
References: <20191209213233.29574-1-u.kleine-koenig@pengutronix.de>
 <20191209213233.29574-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209213233.29574-2-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Dec 09, 2019 at 10:32:33PM +0100, Uwe Kleine-König wrote:
> Rewrite most of the documentation to have the focus on the atomic API
> and mention the legacy stuff only shortly.
> 
> The paragraphs about Locking and Helpers is dropped as they mostly
> describe development outlooks which didn't happen yet (since the promise
> to fix stuff "soon" was introduced in 2011).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Do you have feedback for this patch? IMHO it's a good improvement as it
discards the stuff about the legacy API (only mentioning it at the end)
and concentrates about the stuff that is currently the way to go.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
