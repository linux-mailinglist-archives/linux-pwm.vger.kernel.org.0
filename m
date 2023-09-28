Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCB7B1CC2
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Sep 2023 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjI1MoK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Sep 2023 08:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjI1MoK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Sep 2023 08:44:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4C1A4;
        Thu, 28 Sep 2023 05:44:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFB2C433C7;
        Thu, 28 Sep 2023 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695905047;
        bh=+Z1jCxHUoOc0gZ+StZzFUfNdIzmRgXU20eTsqDnoZn8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uX5R9DADqL5PqGFMO7ZxnhKjyCs0IJNFEkV4jn/NERD43w1h+q+geIkI0oBgf607G
         KluNSAfKMc3IWlXuIvIuh7TZd2Eni9fN98CBKIBNa7olc1g4aVB8E+gU+sxFDEr+eq
         qpt+Ni+BUI4/py0Q8iP+HYo0NZNXsctPyTH1p0OHljT+caYu0z1S6yDM0mANIEfLyc
         vrDnEMfJRXxZFrqagUF47Sa/vaVzjriARQt/hscVQKW/MY3dgg+Ura4LRSmODEBi51
         ACIxQ4C2nxzDQh9Mlfyd+7dqU65eCAw+ANUfJqgarg9ZMP5PUZmV05KDP2tyAE0CHB
         M/L1SGxBeM7KQ==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Rogan Dawes <rogan@dawes.za.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-leds@vger.kernel.org
In-Reply-To: <20230922192834.1695727-1-u.kleine-koenig@pengutronix.de>
References: <20230922192834.1695727-1-u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH v2] leds: pwm: Don't disable the PWM when the
 LED should be off
Message-Id: <169590504531.1567885.17759954403970208491.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 13:44:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 22 Sep 2023 21:28:34 +0200, Uwe Kleine-König wrote:
> Disabling a PWM (i.e. calling pwm_apply_state with .enabled = false)
> gives no guarantees what the PWM output does. It might freeze where it
> currently is, or go in a High-Z state or drive the active or inactive
> state, it might even continue to toggle.
> 
> To ensure that the LED gets really disabled, don't disable the PWM even
> when .duty_cycle is zero.
> 
> [...]

Applied, thanks!

[1/1] leds: pwm: Don't disable the PWM when the LED should be off
      commit: 1025d4c1837eb457f9d599611096bf3a4d954333

--
Lee Jones [李琼斯]

