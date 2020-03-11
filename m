Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92D91822DB
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 20:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgCKTzd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 15:55:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36773 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbgCKTzc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 15:55:32 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jC7Rx-00079X-18; Wed, 11 Mar 2020 20:55:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jC7Rw-0000Pp-FD; Wed, 11 Mar 2020 20:55:28 +0100
Date:   Wed, 11 Mar 2020 20:55:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     rishi gupta <gupt21@gmail.com>
Cc:     thierry.reding@gmail.com, s.trumtrar@pengutronix.de,
        linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
Message-ID: <20200311195528.iplmlcuvp2jjaecn@pengutronix.de>
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
 <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
 <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 01:16:28AM +0530, rishi gupta wrote:
> These 2 links contains more details:
> https://lore.kernel.org/patchwork/patch/732981
> https://lkml.org/lkml/2019/1/17/437

These are both about SIMPLE_DEV_PM_OPS which doesn't apply to
pwm-pca9685.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
